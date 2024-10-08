//
//  SearchView.swift
//  appUI
//
//  Created by 김나훈 on 2023/04/27.
//

import SwiftUI
import Firebase

struct SearchView: View {
    @State private var word = ""
    @State private var num = 0
    @State private var temp = keywords
    @State var checkBox: Bool = receiveAllMessage
    var body: some View {
        
        VStack {
            Text("   KoreaTech ICT")
                .font(.system(size: 25))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(UIColor.systemCyan))
            
            Spacer(minLength: 30)
            
            Text("등록된 키워드").font(.system(size: 30))
            TextField("입력", text: $word)
                .frame(width: 200, height: 40)
                .padding(.horizontal, 20)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            //새로운 키워드를 추가하는 버튼
    
                Button(action: {
                    //배열의 길이가 10개 미만일 때만 새로운 단어를 추가합니다.
                    if temp.count < 10 && !word.isEmpty {
                        //배열에 새로운 단어를 추가한다.
                        temp.append(word)
                        keywords=temp
                        //데이터베이스에 배열을 갱신한다.
                        Database.database().reference().child("User").child(fcm!).child("keywords").setValue(temp)

                        //현재 입력하던 단어는 공백으로 바꿈
                        word = ""
                    }
                }) {
                    Text("추가하기")
                        .frame(width: 150, height: 40)
                        .background(Color.cyan)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.bottom, 20)
                HStack {
                    Text("모든 알림 받기 :  ").font(Font(medium15))
                    Button(action: {
                        checkBox.toggle()
                        let userRef = Database.database().reference().child("User").child(fcm!)
                        
                        if checkBox {
                            // checkBox가 true이면 "sendAll"을 true로 설정
                            userRef.updateChildValues(["sendAll": true])
                        } else {
                            // checkBox가 false이면 "sendAll"을 삭제
                            userRef.child("sendAll").removeValue()
                        }
                    }) {
                        Image(systemName: checkBox ? "checkmark.square" : "square")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30).foregroundColor(.black)
                    }.frame(width:30,height:30)
                   
                }
            
                
                
                
                List {
                    ForEach(temp.indices, id: \.self) { index in
                        HStack {
                            Text("\(index + 1)")
                            Text(temp[index])
                            Spacer()
                            // x버튼으로 등록한 키워드를 삭제하는 버튼
                            Button(action: {
                                //파이어베이스에서 삭제할 위치
                                let refKeyword = Database.database().reference().child("User").child(fcm!).child("keywords")
                                refKeyword.observeSingleEvent(of: .value) { snapshot in
                                    guard var firebaseKeyword = snapshot.value as? [String] else { return }
                                    //배열의 index번호를 삭제
                                    temp.remove(at: index)
                                    keywords=temp
                                    //파이어베이스에 삭제한 배열을 새로 추가
                                    refKeyword.setValue(temp)
                                    
                                }
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .onDelete(perform: deleteKeyword)
                }
                
                ButtonItem()
                
            }
        }
        
        func deleteKeyword(at offsets: IndexSet) {
            temp.remove(atOffsets: offsets)
        }
    }
    
    
    
    
    struct SearchView_Previews: PreviewProvider {
        static var previews: some View {
            SearchView()
        }
    }
