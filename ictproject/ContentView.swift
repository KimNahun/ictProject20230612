//
//  ContentView.swift
//  appUI
//
//  Created by 김나훈 on 2023/04/27.
//

import SwiftUI


struct ContentView: View {
    @State private var word = ""
    @State private var showingOverlay = false
    @State private var showingContentView = false
    var body: some View {
        ZStack {
            NavigationView{
                VStack{
                    HStack {
                        Button(action : {
                            showingOverlay = true
                        }) {
                            Image(systemName:"line.3.horizontal")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 20)
                        }.padding(30)
                        
                        Spacer()
                        
                        HStack {
                            Text("검색: ")
                            TextField("",text: $word,onCommit: {
                                searchWord = word
                            }).frame(width: 70)
                            
                            Button(action: {
                                searchWord = word
                                searchingWord = true
                                showingContentView = true
                                print(searchWord)
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
                        ForEach(0..<totalNotice.count) { index in
                            HStack{
                                NoticeItem(num: index)
                            }
                        }
                    }
                    ButtonItem()
                }
            }
            
            if showingOverlay {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        showingOverlay = false
                    }
                VStack {
                    Button("일반공지") {
                        getFirebase.readFireBaseData(fromPath: "일반공지")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                              showingContentView=true
                              searchingWord = false
                          }
                   
                        
                    }.fullScreenCover(isPresented: $showingContentView, content: {
                        ContentView()
                    })
                    Button("장학공지") {
                        getFirebase.readFireBaseData(fromPath: "장학공지")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                              showingContentView=true
                              searchingWord = false
                          }
                        
                    }
                    .fullScreenCover(isPresented: $showingContentView, content: {
                        ContentView()
                    })
                    
                    Button("학사공지") {
                        getFirebase.readFireBaseData(fromPath: "학사공지")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                              showingContentView=true
                              searchingWord = false
                          }
                    }
                    .fullScreenCover(isPresented: $showingContentView, content: {
                        ContentView()
                    })
                    
                    Button("채용공지") {
                        getFirebase.readFireBaseData(fromPath: "채용공지")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                              showingContentView=true
                              searchingWord = false
                          }
                    }
                    .fullScreenCover(isPresented: $showingContentView, content: {
                        ContentView()
                    })
                }
                .frame(width: 200, height: 200)  // Adjust as needed
                .background(Color.white)
                .cornerRadius(20)
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
