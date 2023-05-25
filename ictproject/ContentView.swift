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
    @State private var noticeType = noticeTypeSelect
    var body: some View {
        ZStack {
            NavigationView{
                VStack{
             //       Text("잡아")
                    HStack {
                        Button(action : {
                            showingOverlay = true
                        }) {
                            Image(systemName:"line.3.horizontal")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 20).foregroundColor(.black)
                        }.padding(20)
                        Text(noticeType).bold().font(.system(size: 20))
                        
                        Spacer()
                       
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
                                Image(systemName:"magnifyingglass")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20).foregroundColor(.black)
                            }
                            .fullScreenCover(isPresented: $showingContentView, content: {
                                ContentView()
                            })
                        
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
                VStack(alignment: .leading) {
                    
                    Text("공지 종류를 선택하세요").font(.system(size: 25)).bold().padding(10)
                    Button("일반공지") {
                        getFirebase.readFireBaseData(fromPath: "일반공지")
                        noticeTypeSelect="일반공지"
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                              showingContentView=true
                              searchingWord = false
                          }
                   
                        
                    }.fullScreenCover(isPresented: $showingContentView, content: {
                        ContentView()
                      
                    }).foregroundColor(.black).padding(10)
                    Button("장학공지") {
                        getFirebase.readFireBaseData(fromPath: "장학공지")
                        noticeTypeSelect="장학공지"
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                              showingContentView=true
                              searchingWord = false
                          }
                        
                    }
                    .fullScreenCover(isPresented: $showingContentView, content: {
                        ContentView()
                    }).foregroundColor(.black).padding(10)
                    
                    Button("학사공지") {
                        getFirebase.readFireBaseData(fromPath: "학사공지")
                        noticeTypeSelect="학사공지"
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                              showingContentView=true
                              searchingWord = false
                          }
                    }
                    .fullScreenCover(isPresented: $showingContentView, content: {
                        ContentView()
                    }).foregroundColor(.black).padding(10)
                    
                    Button("채용공지") {
                        getFirebase.readFireBaseData(fromPath: "채용공지")
                        noticeTypeSelect="채용공지"
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                              showingContentView=true
                              searchingWord = false
                          }
                    }
                    .fullScreenCover(isPresented: $showingContentView, content: {
                        ContentView()
                    }).foregroundColor(.black).padding(10)
                }
                .frame(width: 350, height: 250)  // Adjust as needed
                .background(Color.white)
             
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
            VStack{
                Button(action: {
                    
                    showingSearchView = true
                }) {
                    Image(systemName:"plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30).foregroundColor(.black)
                }
                .fullScreenCover(isPresented: $showingSearchView, content: {
                    
                    SearchView()
                })
                Text("키워드 등록")
            }
            Spacer()
            VStack{
                //새로고침 버튼
                Button(action: {
                    showingContentView = true
                    searchingWord=false
                    
                }) {
                    Image(systemName:"house.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30).foregroundColor(.black)
                }
                .fullScreenCover(isPresented: $showingContentView, content: {
                    ContentView()
                })
                Text("홈")
            }
            Spacer()
            VStack {
                //편의 기능 수행 버튼
                Button(action: {
                    showingConvenienceView = true
                }) {
                    Image(systemName:"folder.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30).foregroundColor(.black)
                }
                .fullScreenCover(isPresented: $showingConvenienceView, content: {
                    ConvenienceView()
                })
                Text("정보")
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
