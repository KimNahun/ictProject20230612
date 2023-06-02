import UIKit
import WebKit
import Firebase

public var lastIdx = 0
public var numberVisited = Set<String>()
//파이어베이스에 등록된 글들을 가려오는 기능
class FireBaseViewController: UIViewController {
    
    //firebase의 멘 headkey를 가져온다.
    var headDB : DatabaseReference  = Database.database().reference()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //내 등록된 키워드를 가져오는 메소드
    func getMyIDData() {
        lastIdx=0
        generalNotice = [[String]](repeating: [String](repeating: "", count: 6), count: 260)
        importantNotice = [[String]](repeating: [String](repeating: "", count: 6), count: 260)
        totalNotice = [[String]](repeating: [String](repeating: "", count: 6), count: 260)
        //refkeyword는 firebase의 유저정보 -> 식별자 -> (내 모바일 기기의 고유번호) -> 등록된 키워드
        keywords = [String]() //사용자가 등록한 키워드
        
        let refKeyword = Database.database().reference().child("User").child(fcm!).child("keywords")
        refKeyword.observeSingleEvent(of: .value) { snapshot in
            //읽어들인 내 키워드들
            guard let readFirbaseKeywords = snapshot.value as? [String] else { return }
            //배열에 내가 등록한 키워드들을 추가한다.
            for i in readFirbaseKeywords {
                keywords.append(i)
            }
        }
      
        let refSendAll = Database.database().reference().child("User").child(fcm!).child("sendAll")
            refSendAll.observeSingleEvent(of: .value) { snapshot in
                // sendAll 값을 읽어들인다. 만약 값이 없으면, false로 간주
                receiveAllMessage = snapshot.value as? Bool ?? false
    
            }
        
        numberVisited = Set<String>()
        let refFavorite = Database.database().reference().child("User").child(fcm!).child("favorite")
        refFavorite.observeSingleEvent(of: .value) { snapshot in
            
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                   let notice = childSnapshot.value as? [String] {
                    totalNotice[lastIdx] = notice
                    numberVisited.insert(notice[1])
                    lastIdx+=1
                }
            }
            
       
        }
    }
    
    func readFireBaseData(fromPath path: String) {
        var idx1 = 0
        var idx1Important = 0
        headDB.child(path).observeSingleEvent(of: .value) { (snapshot) in
            if let data = snapshot.value as? [String: Any] {
                for (_, value) in data {
                    var idx2 = 0
                    var idx2Important = 0
                    if let notice = value as? [String: Any] {
                        if let type = notice["image_tag"] as? Int, type == 1 {
                            if let number = notice["number"] as? String {
                                if(numberVisited.contains(number)){
                                    continue
                                }
                            }
                            if let title = notice["title"] as? String {
                                importantNotice[idx1Important][idx2Important] = title
                                idx2Important+=1
                            }
                            if let number = notice["number"] as? String {
                                importantNotice[idx1Important][idx2Important] = number
                                idx2Important+=1
                            }
                            if let date = notice["date"] as? String {
                                importantNotice[idx1Important][idx2Important] = date
                                idx2Important+=1
                            }
                            if let link = notice["link"] as? String {
                                importantNotice[idx1Important][idx2Important] = link
                                idx2Important+=1
                            }
                            if let writer = notice["writer"] as? String {
                                importantNotice[idx1Important][idx2Important] = writer
                                idx2Important+=1
                            }
                            importantNotice[idx1Important][idx2Important]="1"
                            idx1Important+=1
                        } else {
                            // If image_tag is not 1 or is not present, save to regular array
                            if let title = notice["title"] as? String {
                                generalNotice[idx1][idx2] = title
                                idx2+=1
                            }
                            if let number = notice["number"] as? String {
                                generalNotice[idx1][idx2] = number
                                idx2+=1
                            }
                            if let date = notice["date"] as? String {
                                generalNotice[idx1][idx2] = date
                                idx2+=1
                            }
                            if let link = notice["link"] as? String {
                                generalNotice[idx1][idx2] = link
                                idx2+=1
                            }
                            if let writer = notice["writer"] as? String {
                                generalNotice[idx1][idx2] = writer
                                idx2+=1
                            }
                            generalNotice[idx1][idx2]="0"
                            idx1+=1
                        }
                    }
                }
            } else {
                print("Error decoding data")
            }

            generalNotice.sort { (item1, item2) -> Bool in
                guard let number1 = Int(item1[1]), let number2 = Int(item2[1]) else {
                    return false
                }
                return number1 > number2
            }
            
            importantNotice.sort { (item1, item2) -> Bool in
                guard let number1 = Int(item1[1]), let number2 = Int(item2[1]) else {
                    return false
                }
                return number1 > number2
            }
            
            var totalIdx = lastIdx+1
            
            for notice in importantNotice {
                // title이 ""이 아닌 것만 추가
                if notice[0] != "" {
                    totalNotice[totalIdx] = notice
                    totalIdx += 1
                }
            }
            for notice in generalNotice {
                // title이 ""이 아닌 것만 추가
                if notice[0] != "" {
                    totalNotice[totalIdx] = notice
                    totalIdx += 1
                }
            }
            
            
            
            
        }
    }
    
    
    
    
}

