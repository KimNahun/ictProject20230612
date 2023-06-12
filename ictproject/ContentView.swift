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
    @State private var isNoticeButtonDisabled = false  // 추가된 State 변수
    var body: some View {
        VStack{
            Text("   KoreaTech ICT")
                .font(.system(size: 25))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(UIColor.systemCyan))

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
                                    .frame(height: 20).foregroundColor(.black)
                            }.padding(20)
                            Text(noticeType).bold().font(.system(size: 20))
                            
                            Spacer()
                            
                            Text("검색: ")
                            TextField("",text: $word,onCommit: {
                                searchWord = word
                                searchingWord = true
                                showingContentView = true
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
                            }.padding(10)
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
                            getFirebase.getMyIDData()
                            getFirebase.readFireBaseData(fromPath: "일반공지")
                            noticeTypeSelect="일반공지"
                            isNoticeButtonDisabled = true  // 버튼을 비활성화
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                showingContentView=true
                                searchingWord = false
                                isNoticeButtonDisabled = false  // 2초 후에 버튼을 다시 활성화
                            }
                            
                            
                        }.disabled(isNoticeButtonDisabled)  // Button에 추가된 disabled modifier
                        .fullScreenCover(isPresented: $showingContentView, content: {
                            ContentView()
                            
                        }).foregroundColor(.black).padding(10)
                        Button("장학공지") {
                            getFirebase.getMyIDData()
                            getFirebase.readFireBaseData(fromPath: "장학공지")
                            noticeTypeSelect="장학공지"
                            isNoticeButtonDisabled = true  // 버튼을 비활성화
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                showingContentView=true
                                searchingWord = false
                                isNoticeButtonDisabled = false  // 2초 후에 버튼을 다시 활성화
                            }
                            
                        }.disabled(isNoticeButtonDisabled)  // Button에 추가된 disabled modifier
                        .fullScreenCover(isPresented: $showingContentView, content: {
                            ContentView()
                        }).foregroundColor(.black).padding(10)
                        
                        Button("학사공지") {
                            getFirebase.getMyIDData()
                            getFirebase.readFireBaseData(fromPath: "학사공지")
                            noticeTypeSelect="학사공지"
                            isNoticeButtonDisabled = true  // 버튼을 비활성화
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                showingContentView=true
                                searchingWord = false
                                isNoticeButtonDisabled = false  // 2초 후에 버튼을 다시 활성화
                            }
                        }.disabled(isNoticeButtonDisabled)  // Button에 추가된 disabled modifier
                        .fullScreenCover(isPresented: $showingContentView, content: {
                            ContentView()
                        }).foregroundColor(.black).padding(10)
                        
                        Button("채용공지") {
                            getFirebase.getMyIDData()
                            getFirebase.readFireBaseData(fromPath: "채용공지")
                            noticeTypeSelect="채용공지"
                            isNoticeButtonDisabled = true  // 버튼을 비활성화
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                showingContentView=true
                                searchingWord = false
                                isNoticeButtonDisabled = false  // 2초 후에 버튼을 다시 활성화
                            }
                        }.disabled(isNoticeButtonDisabled)  // Button에 추가된 disabled modifier
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
}


struct ButtonItem: View {
    @State var bookMark: Bool = false
    @State private var showingContentView = false
    @State private var showingSearchView = false
    @State private var showingConvenienceView = false
    @State private var isHomeButtonDisabled = false  // 추가된 State 변수
    var body: some View {
        HStack(spacing:100) {
            //버튼 누르면 키워드 등록하는 view로 감
            VStack{
                Button(action: {
                    showingSearchView = true
                }) {
                    Image(systemName:"plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30).foregroundColor(.cyan)
                }
                .fullScreenCover(isPresented: $showingSearchView, content: {
                    SearchView()
                })
                Text("키워드").font(Font(medium15))
            }
            //   Spacer()
            VStack{
                //새로고침 버튼
                Button(action: {
                    isHomeButtonDisabled = true  // 버튼을 비활성화
                    getFirebase.getMyIDData()
                    getFirebase.readFireBaseData(fromPath: noticeTypeSelect)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        showingContentView = true
                        searchingWord=false
                        isHomeButtonDisabled = false  // 1초 후에 버튼을 다시 활성화
                    }
                    
                    
                }) {
                    Image(systemName:"house.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30).foregroundColor(.cyan)
                }.disabled(isHomeButtonDisabled)
      
                .fullScreenCover(isPresented: $showingContentView, content: {
                    ContentView()
                })
                Text("홈").font(Font(medium15))
            }
    
            VStack {
                //편의 기능 수행 버튼
                Button(action: {
                    showingConvenienceView = true
                }) {
                    Image(systemName:"folder.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30).foregroundColor(.cyan)
                }
       
                .fullScreenCover(isPresented: $showingConvenienceView, content: {
                    ConvenienceView()
                })
                Text("정보").font(Font(medium15))
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
