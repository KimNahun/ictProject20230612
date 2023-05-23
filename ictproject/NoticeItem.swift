//
//  NoticeItem.swift
//  appUI
//
//  Created by 김나훈 on 2023/04/27.
//



import SwiftUI
import SafariServices

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
                            VStack{
                                HStack{
                                    Text(String(totalNotice[num][1])) //번호
                                        .foregroundColor(.black)
                                        .lineLimit(nil)
                                        .padding(.bottom, 1)
                                    Spacer()
                                    Text(String(totalNotice[num][0])) //제목
                                        .foregroundColor(.black)
                                        .lineLimit(nil)
                                        .padding(.bottom, 1)
                                }
                                Spacer()
                                HStack{
                                    Text(String(totalNotice[num][4])) //부서
                                        .foregroundColor(.black)
                                        .lineLimit(nil)
                                        .padding(.bottom, 1)
                                
                                    Text(String(totalNotice[num][2])) //날짜
                                        .foregroundColor(.black)
                                        .lineLimit(nil)
                                        .padding(.bottom, 1)
                                    Spacer()
                                    if(totalNotice[num][5]=="1"){
                                        Text("notice")
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .frame(minHeight: 30, maxHeight: .infinity, alignment: .topLeading)
                            .frame(width:350)
                            .background(Color.white)
                            .border(Color.black, width: 1)
                           
                        }
                    }

                
                }
            } else {
                if let validURL = URL(string: totalNotice[num][3]) {
                    NavigationLink(destination: SafariView(url: validURL)) {
                        VStack{
                            HStack{
                                Text(String(totalNotice[num][1])) //번호
                                    .foregroundColor(.black)
                                    .lineLimit(nil)
                                    .padding(.bottom, 1)
                                Spacer()
                                Text(String(totalNotice[num][0])) //제목
                                    .foregroundColor(.black)
                                    .lineLimit(nil)
                                    .padding(.bottom, 1)
                            }
                            Spacer()
                            HStack{
                                Text(String(totalNotice[num][4])) //부서
                                    .foregroundColor(.black)
                                    .lineLimit(nil)
                                    .padding(.bottom, 1)
                            
                                Text(String(totalNotice[num][2])) //날짜
                                    .foregroundColor(.black)
                                    .lineLimit(nil)
                                    .padding(.bottom, 1)
                                Spacer()
                                if(totalNotice[num][5]=="1"){
                                    Text("notice")
                                }
                            }
                        }
                        .padding(.horizontal)
                        .frame(minHeight: 30, maxHeight: .infinity, alignment: .topLeading)
                        .frame(width:350)
                        .background(Color.white)
                        .border(Color.black, width: 1)
                       
                    }
                }

            }
        }
    }
}



