//
// NoticeItem.swift
// appUI
//
// Created by 김나훈 on 2023/04/27.
//

import SwiftUI
import SafariServices
import Firebase
public let medium15 = UIFont(name: "Pretendard-Medium",size:15)!
public let medium25 = UIFont(name: "Pretendard-Medium",size:25)!
public let regular15 = UIFont(name: "Pretendard-Regular",size:15)!
public let semiBold15 = UIFont(name: "Pretendard-SemiBold",size:15)!
public let light15 = UIFont(name: "Pretendard-Light",size:15)!
public let bold15 = UIFont(name: "Pretendard-Bold",size:15)!
public let medium10 = UIFont(name: "Pretendard-Medium",size:10)!
public let regular10 = UIFont(name: "Pretendard-Regular",size:10)!
public let semiBold10 = UIFont(name: "Pretendard-SemiBold",size:10)!
public let light10 = UIFont(name: "Pretendard-Light",size:10)!
public let bold10 = UIFont(name: "Pretendard-Bold",size:10)!
//safari view 로 수행.
struct SafariView: UIViewControllerRepresentable {
    let url: URL
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
        // No update needed
    }
}

struct NoticeItem: View {
    var num: Int
    @State private var favorite: Bool = false
    var body: some View {
        VStack(spacing:0) {
            
            if searchingWord {
                if totalNotice[num][0].contains(searchWord) {
                    if let validURL = URL(string: totalNotice[num][3]) {
                        NavigationLink(destination: SafariView(url: validURL)) {
                            VStack(spacing:0) {///
                                HStack {
                                    Text(totalNotice[num][1]).font(Font(medium15))
                                        .foregroundColor(.black)
                                    if(totalNotice[num][5]=="1"){
                                        Text("NOTICE").font(Font(medium15))
                                            .foregroundColor(.white)
                                            .background(Color.red)
                                    }
                                    Spacer()
                                    Button(action: {
                                        favorite.toggle()
                                        // Reference to the user's favorites in Firebase
                                        let ref = Database.database().reference().child("User").child(fcm!).child("favorite")
                                        
                                        ref.observeSingleEvent(of: .value, with: { snapshot in
                                            let favoritesCount = snapshot.childrenCount
                                            // If the user has less than 40 favorites, allow them to add more
                                            
                                            if favorite {
                                                numberVisited.insert(totalNotice[num][1])
                                                if favoritesCount < 40 {
                                                    let favoriteData = totalNotice[num][0...5].reduce(into: [String: String]()) { dict, item in
                                                        dict[String(dict.count)] = item
                                                    }
                                                    let childUpdates = ["User/\(fcm!)/favorite/\(totalNotice[num][1])": favoriteData]
                                                    Database.database().reference().updateChildValues(childUpdates)
                                                }
                                                else {
                                                    numberVisited.remove(totalNotice[num][1])
                                                    favorite.toggle()
                                                    // If the user already has 40 or more favorites, don't allow them to add more
                                                    print("Cannot add more than 40 favorites.")
                                                }
                                            }
                                            else {
                                                numberVisited.remove(totalNotice[num][1])
                                                // favorite가 false일 때의 동작
                                                let favoriteNumber = totalNotice[num][1]
                                                // 데이터베이스에서 해당 번호의 favorite 제거
                                                Database.database().reference().child("User").child(fcm!).child("favorite").child(favoriteNumber).removeValue()
                                            }
                                        })
                                        
                                    }) {
                                        Image(systemName: favorite ? "star.fill" : "star").foregroundColor(favorite ? .yellow : .gray)
                                    }
                                }.padding(5)
                                HStack{
                                    
                                    Text(totalNotice[num][0]).font(Font.custom("Pretendard-Bold",size:17))
                                        .foregroundColor(.black)
                                        .multilineTextAlignment(.leading) // 왼쪽 정렬로 설정
                                        .lineSpacing(5) // 간격을 조정하려는 값으로 변경하세요
                                    
                                    Spacer()
                                    
                                }.padding(5)
                                
                                
                                HStack {
                                    Text(totalNotice[num][4]).font(Font(medium15)) .foregroundColor(.black)
                                    Text(totalNotice[num][2]).font(Font(medium15)) .foregroundColor(.black)
                                    Spacer()
                                }.padding(5)
                            }.onAppear {
                                favorite = numberVisited.contains(totalNotice[num][1])
                            }
                            ///
                            .border(Color.black, width: 1)
                            
                        }
                    }
                    
                    
                }
            } else {
                if let validURL = URL(string: totalNotice[num][3]) {
                    NavigationLink(destination: SafariView(url: validURL)) {
                        VStack(spacing:0){///
                            HStack {
                                
                                Text(totalNotice[num][1]).font(Font(medium15))
                                    .foregroundColor(.black)
                                if(totalNotice[num][5]=="1"){
                                    Text("NOTICE").font(Font(medium15))
                                        .foregroundColor(.white)
                                        .background(Color.red)
                                }
                                Spacer()
                                Button(action: {
                                    favorite.toggle()
                                    // Reference to the user's favorites in Firebase
                                    let ref = Database.database().reference().child("User").child(fcm!).child("favorite")
                                    
                                    ref.observeSingleEvent(of: .value, with: { snapshot in
                                        let favoritesCount = snapshot.childrenCount
                                        // If the user has less than 40 favorites, allow them to add more
                                        
                                        if favorite {
                                            numberVisited.insert(totalNotice[num][1])
                                            if favoritesCount < 40 {
                                                let favoriteData = totalNotice[num][0...5].reduce(into: [String: String]()) { dict, item in
                                                    dict[String(dict.count)] = item
                                                }
                                                let childUpdates = ["User/\(fcm!)/favorite/\(totalNotice[num][1])": favoriteData]
                                                Database.database().reference().updateChildValues(childUpdates)
                                            }
                                            else {
                                                numberVisited.remove(totalNotice[num][1])
                                                favorite.toggle()
                                                // If the user already has 40 or more favorites, don't allow them to add more
                                                print("Cannot add more than 40 favorites.")
                                            }
                                        }
                                        else {
                                            numberVisited.remove(totalNotice[num][1])
                                            // favorite가 false일 때의 동작
                                            let favoriteNumber = totalNotice[num][1]
                                            // 데이터베이스에서 해당 번호의 favorite 제거
                                            Database.database().reference().child("User").child(fcm!).child("favorite").child(favoriteNumber).removeValue()
                                        }
                                    })
                                    
                                    
                                }) {
                                    Image(systemName: favorite ? "star.fill" : "star").foregroundColor(favorite ? .yellow : .gray)
                                }
                            }.padding(5)
                            HStack {
                                
                                Text(totalNotice[num][0]).font(Font.custom("Pretendard-Bold",size:17))
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.leading) // 왼쪽 정렬로 설정
                                    .lineSpacing(5) // 간격을 조정하려는 값으로 변경하세요
                                
                                Spacer()
                                
                            }.padding(5)
                            
                            
                            HStack {
                                Text(totalNotice[num][4]).font(Font(medium15)) .foregroundColor(.black)
                                Text(totalNotice[num][2]).font(Font(medium15)) .foregroundColor(.black)
                                Spacer()
                            }.padding(5)
                        }.onAppear {
                            favorite = numberVisited.contains(totalNotice[num][1])
                        }
                        ///
                        ///
                        .border(Color.black, width: 1)
                    }
                }
                
                
                
                
                
                
                
            }
        }.onAppear {
            favorite = num <= lastIdx
        }
    }
}
