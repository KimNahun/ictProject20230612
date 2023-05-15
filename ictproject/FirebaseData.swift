import UIKit
import WebKit
import Firebase


//파이어베이스에 등록된 글들을 가려오는 기능
class FireBaseViewController: UIViewController {
    
    //firebase의 멘 headkey를 가져온다.
    var headDB : DatabaseReference  = Database.database().reference()
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //내 등록된 키워드를 가져오는 메소드
    func getMyIDData() {
        //refkeyword는 firebase의 유저정보 -> 식별자 -> (내 모바일 기기의 고유번호) -> 등록된 키워드
        
        let refKeyword = Database.database().reference().child("User").child(fcm!)
            refKeyword.observeSingleEvent(of: .value) { snapshot in
                //읽어들인 내 키워드들
                guard let readFirbaseKeywords = snapshot.value as? [String] else { return }
                //배열에 내가 등록한 키워드들을 추가한다.
                for i in readFirbaseKeywords {
                    keywords.append(i)
                }
            }
    }
    
    
   
    
    //일반공지의 글을 가져오는 함수
    func readFireBaseData1() {

        if(tempTitle1.count==0){
            var idx1 = 0
            headDB.child("일반공지").observeSingleEvent(of: .value) { (snapshot) in
                if let data = snapshot.value as? [String: Any] {
                    for (key, value) in data {
                        var idx2 = 0
                        if let notice = value as? [String: Any] {
                            if let title = notice["title"] as? String {
                                tempTitle1.append(title)
                                myArray1[idx1][idx2] = title
                                idx2+=1
                                //                     print(title)
                            }
                            if let number = notice["number"] as? String {
                                //                    print(number)
                                myArray1[idx1][idx2] = number
                                idx2+=1
                            }
                            if let category = notice["category"] as? String {
                                //                   print(category)
                                
                            }
                            if let date = notice["date"] as? String {
                                //                    print(date)
                                myArray1[idx1][idx2] = date
                                idx2+=1
                            }
                            if let link = notice["link"] as? String {
                                //                    print(link)
                                myArray1[idx1][idx2] = link
                                idx2+=1
                            }
                            if let writer = notice["writer"] as? String {
                                //                   print(writer)
                                myArray1[idx1][idx2] = writer
                                idx2+=1
                            }
                        }
                        idx1+=1
                        
                    }
                } else {
                    print("Error decoding data")
                }
                
                tempTitle=tempTitle1
                myArray=myArray1
                
                
            }
            
        }
    }
    //장학공지의 글을 가져오는 함수
    func readFireBaseData2() {
        
        if(tempTitle2.count==0){
            var idx1 = 0
            headDB.child("장학공지").observeSingleEvent(of: .value) { (snapshot) in
                
                if let data = snapshot.value as? [String: Any] {
                    for (key, value) in data {
                        var idx2 = 0
                        if let notice = value as? [String: Any] {
                            if let title = notice["title"] as? String {
                                tempTitle2.append(title)
                                myArray2[idx1][idx2] = title
                                idx2+=1
                                //                     print(title)
                            }
                            if let number = notice["number"] as? String {
                                //                    print(number)
                                myArray2[idx1][idx2] = number
                                idx2+=1
                            }
                            if let category = notice["category"] as? String {
                                //                   print(category)
                                
                            }
                            if let date = notice["date"] as? String {
                                //                    print(date)
                                myArray2[idx1][idx2] = date
                                idx2+=1
                            }
                            if let link = notice["link"] as? String {
                                //                    print(link)
                                myArray2[idx1][idx2] = link
                                idx2+=1
                            }
                            if let writer = notice["writer"] as? String {
                                //                   print(writer)
                                myArray2[idx1][idx2] = writer
                                idx2+=1
                            }
                        }
                        idx1+=1
                        
                    }
                } else {
                    print("Error decoding data")
                }
                
                tempTitle=tempTitle2
                
                
            }
            
        }
    }
    //학사공지의 글을 가져오는 함수
    func readFireBaseData3() {
        
        if(tempTitle3.count==0){
            var idx1 = 0
            headDB.child("학사공지").observeSingleEvent(of: .value) { (snapshot) in
                
                if let data = snapshot.value as? [String: Any] {
                    for (key, value) in data {
                        var idx2 = 0
                        if let notice = value as? [String: Any] {
                            if let title = notice["title"] as? String {
                                tempTitle3.append(title)
                                myArray3[idx1][idx2] = title
                                idx2+=1
                                //                     print(title)
                            }
                            if let number = notice["number"] as? String {
                                //                    print(number)
                                myArray3[idx1][idx2] = number
                                idx2+=1
                            }
                            if let category = notice["category"] as? String {
                                //                   print(category)
                                
                            }
                            if let date = notice["date"] as? String {
                                //                    print(date)
                                myArray3[idx1][idx2] = date
                                idx2+=1
                            }
                            if let link = notice["link"] as? String {
                                //                    print(link)
                                myArray3[idx1][idx2] = link
                                idx2+=1
                            }
                            if let writer = notice["writer"] as? String {
                                //                   print(writer)
                                myArray3[idx1][idx2] = writer
                                idx2+=1
                            }
                        }
                        idx1+=1
                        
                    }
                } else {
                    print("Error decoding data")
                }
                
                
                myArray=myArray3
                
                
            }
            
        }
    }
}
