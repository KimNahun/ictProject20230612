//
// NoticeItem.swift
// appUI
//
// Created by 김나훈 on 2023/04/27.
//

import SwiftUI
import SafariServices
public let medium = UIFont(name: "Pretendard-Medium",size:15)!
public let regular = UIFont(name: "Pretendard-Regular",size:15)!
public let semiBold = UIFont(name: "Pretendard-SemiBold",size:15)!
public let light = UIFont(name: "Pretendard-Light",size:15)!
public let bold = UIFont(name: "Pretendard-Bold",size:15)!
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
    var body: some View {
        VStack {
            if searchingWord {
                if totalNotice[num][0].contains(searchWord) {
                    if let validURL = URL(string: totalNotice[num][3]) {
                        NavigationLink(destination: SafariView(url: validURL)) {
                            VStack {///
                                HStack {
                                    Text(totalNotice[num][1]).font(Font(medium))
                                        .foregroundColor(.black)
                                    if(totalNotice[num][5]=="1"){
                                        Text("NOTICE").font(Font(medium))
                                            .foregroundColor(.white)
                                            .background(Color.red)
                                    }
                                    Spacer()
                                    
                                }.padding(5)
                                HStack {
                                    Text(totalNotice[num][0]).font(Font.custom("Pretendard-Bold",size:17))
                                        .foregroundColor(.black)
                                        .multilineTextAlignment(.leading) // 왼쪽 정렬로 설정
                                        .lineSpacing(5) // 간격을 조정하려는 값으로 변경하세요
                                        
                                    Spacer()
                                     
                                }


                                HStack {
                                    Text(totalNotice[num][4]).font(Font(medium)) .foregroundColor(.black)
                                    Text(totalNotice[num][2]).font(Font(medium)) .foregroundColor(.black)
                                    Spacer()
                                }.padding(5)
                            }///
                            .border(Color.black, width: 1)
                            
                        }
                    }
                    
                    
                }
            } else {
                if let validURL = URL(string: totalNotice[num][3]) {
                    NavigationLink(destination: SafariView(url: validURL)) {
                        VStack {///
                            HStack {
                                Text(totalNotice[num][1]).font(Font(medium))
                                    .foregroundColor(.black)
                                if(totalNotice[num][5]=="1"){
                                    Text("NOTICE").font(Font(medium))
                                        .foregroundColor(.white)
                                        .background(Color.red)
                                }
                                Spacer()
                                
                            }.padding(5)
                            HStack {
                                Text(totalNotice[num][0]).font(Font.custom("Pretendard-Bold",size:17))
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.leading) // 왼쪽 정렬로 설정
                                    .lineSpacing(5) // 간격을 조정하려는 값으로 변경하세요
                                    
                                Spacer()
                                 
                            }


                            HStack {
                                Text(totalNotice[num][4]).font(Font(medium)) .foregroundColor(.black)
                                Text(totalNotice[num][2]).font(Font(medium)) .foregroundColor(.black)
                                Spacer()
                            }.padding(5)
                        }///
                        .border(Color.black, width: 1)
                    }
                }
                
                
                
                
                
                
                
            }
        }
    }
}
