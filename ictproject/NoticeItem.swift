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
                if myArray[num][0].contains(searchWord) {
                    if let validURL = URL(string: myArray[num][3]) {
                        NavigationLink(destination: SafariView(url: validURL)) {
                            VStack(spacing: 0) {
                                HStack{
                                    Text(String(myArray[num][1])).foregroundColor(.black).lineLimit(nil)//번호
                                    Text(String(myArray[num][0])).foregroundColor(.black).lineLimit(nil)// 무슨 글인지
                                }
                                HStack{
                                    Text(String(myArray[num][4])).foregroundColor(.black).lineLimit(nil)
                                    Text(String(myArray[num][2])).foregroundColor(.black).lineLimit(nil)
                                }
                              
                               
                            } .frame(width: 350, height: 100)
                            .border(Color.black, width: 1)
                        }
                    }
                }
            } else {
                if let validURL = URL(string: myArray[num][3]) {
                    NavigationLink(destination: SafariView(url: validURL)) {
                        VStack{
                            HStack{
                                Text(String(myArray[num][1])) //번호
                                    .foregroundColor(.black)
                                    .lineLimit(nil)
                                    .padding(.bottom, 1)
                                Spacer()
                                Text(String(myArray[num][0])) //제목
                                    .foregroundColor(.black)
                                    .lineLimit(nil)
                                    .padding(.bottom, 1)
                            }
                            Spacer()
                            HStack{
                                Text(String(myArray[num][4])) //부서
                                    .foregroundColor(.black)
                                    .lineLimit(nil)
                                    .padding(.bottom, 1)
                            
                                Text(String(myArray[num][2])) //날짜
                                    .foregroundColor(.black)
                                    .lineLimit(nil)
                                    .padding(.bottom, 1)
                                Spacer()
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



