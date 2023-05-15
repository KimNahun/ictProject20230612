/* eslint-disable */
const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

const noticeTypes = {
    'general': '일반공지',
    'scholarship': '장학공지',
    'academic': '학사공지',
    'employment': '취업공지'
};

Object.keys(noticeTypes).forEach(noticeTypeKey => {
    const noticeType = noticeTypes[noticeTypeKey];
    exports[`sendNotification_${noticeTypeKey}`] = functions.database.ref(`/${noticeType}/{pushId}`)
        .onCreate((snapshot, context) => {
            const notice = snapshot.val();

            // Firebase Realtime Database에서 /User의 데이터를 가져옵니다.
            const userRef = admin.database().ref('/User');
            return userRef.once('value').then(snapshot => {
                const users = snapshot.val();

                // 모든 사용자에 대해
                for (let userToken in users) {
                    // 모든 키워드에 대해
                    for (let keyword of users[userToken]) {
                        // 키워드가 공지의 title에 있다면
                        if (notice['title'].includes(keyword)) {
                            // 해당 유저에게 메시지를 보냅니다.
                            var message = {
                                notification: {
                                    title: `${noticeType}에 '${keyword}'의 글이 추가되었습니다.`,
                                    body: notice['title']
                                },
                                android: {
                                    notification: {
                                        sound: 'default'
                                    }
                                },
                                apns: {
                                    payload: {
                                        aps: {
                                            sound: 'default'
                                        }
                                    }
                                },
                                token: userToken
                            };

                            admin.messaging().send(message)
                                .then((response) => {
                                    console.log('Successfully sent message:', response);
                                })
                                .catch((error) => {
                                    console.log('Error sending message:', error);
                                });
                        }
                    }
                }
            });
        });
});
