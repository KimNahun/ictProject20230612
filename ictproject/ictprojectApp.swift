import SwiftUI
import FirebaseCore
import Firebase
import UserNotifications
//import FirebaseMessaging
//공지 크롤링


public var generalNotice = [[String]](repeating: [String](repeating: "", count: 6), count: 40)
public var importantNotice = [[String]](repeating: [String](repeating: "", count: 6), count: 40)
public var totalNotice = [[String]](repeating: [String](repeating: "", count: 6), count: 40)

public var keywords = [String]() //사용자가 등록한 키워드
public var noticeTitle = [String]()
public var searchWord = "" //검색중인단어
public var searchingWord = false //검색중인상태
public var fcm:String? = ""

var getFirebase = FireBaseViewController()


class AppDelegate: NSObject, UIApplicationDelegate {
    
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        //파이어베이스 초기화
        FirebaseApp.configure()
        
        //여기서부터는 왜있는지 잘모르겠음.
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: { _, _ in }
            )
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
        

        return true
        
        
    }
    //이거도 왜있는지 잘 모름
    //fcm 토큰을 얻는 걸로 추정
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
 //       print("APNs device token: \(token)")
        
        // Set APNs token for Firebase Cloud Messaging
        Messaging.messaging().apnsToken = deviceToken
    }
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
}

extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
     //   print("FCM registration token: \(fcmToken ?? "")")
        //fcm 토큰을 추출하고, 그 후에 파이어베이스 데이터를 긁어온다
        fcm = fcmToken
        getFirebase.readFireBaseData(fromPath: "일반공지")
        getFirebase.getMyIDData()
    }
    
}



@main
struct ictprojectApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            LoadingView()
            //3초 딜레이가 된 후 ContentView 실행
            DelayedView(delay: 3.0) {
                ContentView()
            }
        }
    }
    
}



