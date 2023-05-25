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
                // Update with image_tag
                visitedRef.child(notice.number).set(notice.image_tag === 1);
		        return null;
            } else {
                visitedRef.update({[notice.number]: notice.image_tag === 1});
                // Prune the database if it has more than 50 records.
                if (visitedSnapshot.numChildren() > 100) {
                    const childKeys = Object.entries(visitedSnapshot.val()).filter(([key, value]) => !value);
                    childKeys.sort((a, b) => a[0] - b[0]); // Sort keys in ascending order.
                    if (childKeys.length > 0) {
                        visitedRef.child(childKeys[0][0]).remove(); // Remove the smallest key.
                    }
                }
            }

            const userRef = admin.database().ref('/User');
            return userRef.once('value').then(snapshot => {
                const users = snapshot.val();
                let notifiedUsers = new Set();

                for (let userToken in users) {
                    if (notifiedUsers.has(userToken)) {
                        continue;
                    }
                    // If sendAll exists and is true, send notification without checking keywords
                    if (users[userToken].sendAll) {
                        var message = {
                            notification: {
                                title: `${noticeType}에 새로운 글이 추가되었습니다.`,
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
                                notifiedUsers.add(userToken);
                            })
                            .catch((error) => {
                                console.log('Error sending message:', error);
                            });
                    } else {
                        let userKeywords = users[userToken].keywords;
                        for (let keywordIndex in userKeywords) {
                            let keyword = userKeywords[keywordIndex];
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
                                        notifiedUsers.add(userToken);
                                    })
                                    .catch((error) => {
                                        console.log('Error sending message:', error);
                                    });
                                break;
                            }
                        }
                    }
                }
            });
        });
});
