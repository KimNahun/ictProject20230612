//
//  ContentView.swift
//  appUI
//
//  Created by 김나훈 on 2023/04/27.
//

import SwiftUI

var thisFirebase=FireBaseViewController()

struct ContentView: View {
    @State private var word = ""
    @State private var showingContentView = false
    @State private var showingSelectView = false
    var body: some View {
        NavigationView{
            VStack{
                HStack {
                    //버튼 누르면 일반공지, 장학공지 등등 선택 가능
                    Button(action : {
                        showingSelectView=true
                    }) {
                        Image(systemName:"line.3.horizontal")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 20)
                    }.padding(30).fullScreenCover(isPresented: $showingSelectView, content: {
                        SelectView()
                    })
                    
                    Spacer()
                    //검색 기능
                    //내가 검색한 단어만 나오게 함
                    HStack {
                       Text("검색: ")
                        TextField("",text: $word,onCommit: {
                                searchWord = word
                              
                           }).frame(width: 70)
                        //버튼 눌렀을 때 이벤트 처리
                        Button(action: {
                            searchWord = word
                            searchingWord = true
                            showingContentView = true
                        }) {
                            Image(systemName:"pencil.line")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                        .fullScreenCover(isPresented: $showingContentView, content: {
                          
                         
                            ContentView()
                        })
                        
                    }
                }
                
              
                ScrollView{
                    
                    ForEach(0..<myArray.count) { index in
                        HStack{
                            NoticeItem(num: index)
                        }
                    }
                    
                }
                
                
                
                ButtonItem()
                
            }

            
        }
        
    }
}

struct ButtonItem: View {
    @State var bookMark: Bool = false
    @State private var showingContentView = false
    @State private var showingSearchView = false
    @State private var showingConvenienceView = false
    var body: some View {
        HStack {
            //버튼 누르면 키워드 등록하는 view로 감
            Button(action: {
             
                showingSearchView = true
            }) {
                Image(systemName:"magnifyingglass")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
            }
            .fullScreenCover(isPresented: $showingSearchView, content: {
           
                SearchView()
            })
            .padding(20)
            
            //새로고침 버튼
            Button(action: {
                thisFirebase.readFireBaseData1()
                thisFirebase.readFireBaseData2()
                thisFirebase.readFireBaseData3()
                showingContentView = true
                searchingWord=false
                
            }) {
                Image(systemName:"house")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
            }
            .fullScreenCover(isPresented: $showingContentView, content: {
                ContentView()
            })
            .padding(20)
            //편의 기능 수행 버튼
            Button(action: {
                showingConvenienceView = true
            }) {
                Image(systemName:"line.3.horizontal")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
            }
            .fullScreenCover(isPresented: $showingConvenienceView, content: {
                ConvenienceView()
            })
            .padding(20)
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
