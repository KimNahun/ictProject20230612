/* eslint-disable */
const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

const noticeTypes = {
    'general': '일반공지',
    'scholarship': '장학공지',
    'academic': '학사공지',
    'employment': '채용공지'
};

Object.keys(noticeTypes).forEach(noticeTypeKey => {
    const noticeType = noticeTypes[noticeTypeKey];
    exports[`sendNotification_${noticeTypeKey}`] = functions.database.ref(`/${noticeType}/{pushId}`)
        .onCreate(async (snapshot, context) => {
            const notice = snapshot.val();

            // Get a database reference to our visited notices
            const visitedRef = admin.database().ref(`/visited/${noticeType}`);
            const visitedSnapshot = await visitedRef.once('value');

            if (visitedSnapshot.hasChild(notice.number)) {
                console.log('Notice has already been processed:', notice.number);
                return null;
            } else {
                visitedRef.update({[notice.number]: true});
                // Prune the database if it has more than 30 records.
                if (visitedSnapshot.numChildren() > 50) {
                    const childKeys = Object.keys(visitedSnapshot.val());
                    childKeys.sort((a, b) => a - b); // Sort keys in ascending order.
                    visitedRef.child(childKeys[0]).remove(); // Remove the smallest key.
                }
            }

            const userRef = admin.database().ref('/User');
            return userRef.once('value').then(snapshot => {
                const users = snapshot.val();

                for (let userToken in users) {
                    for (let keyword of users[userToken]) {
                        if (notice['title'].includes(keyword)) {
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
