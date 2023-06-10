import SwiftUI

struct ContentView: View {
    @State private var word = ""
    @State private var showingOverlay = false
    @State private var noticeType = noticeTypeSelect
    @State private var isActive: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text("   KoreaTech ICT")
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(UIColor.systemCyan))

                    VStack {
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

                            NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true), isActive: $isActive) {
                                Button(action: {
                                    searchWord = word
                                    searchingWord = true
                                    isActive = true
                                    print(searchWord)
                                }) {
                                    Image(systemName:"magnifyingglass")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20).foregroundColor(.black)
                                }
                            }.padding(10)
                        }

                        ScrollView {
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
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                isActive=true
                                searchingWord = false
                            }
                        }.foregroundColor(.black).padding(10)
                        
                        Button("장학공지") {
                            getFirebase.getMyIDData()
                            getFirebase.readFireBaseData(fromPath: "장학공지")
                            noticeTypeSelect="장학공지"
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                isActive=true
                                searchingWord = false
                            }
                        }.foregroundColor(.black).padding(10)
                        
                        Button("학사공지") {
                            getFirebase.getMyIDData()
                            getFirebase.readFireBaseData(fromPath: "학사공지")
                            noticeTypeSelect="학사공지"
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                isActive=true
                                searchingWord = false
                            }
                        }.foregroundColor(.black).padding(10)
                        
                        Button("채용공지") {
                            getFirebase.getMyIDData()
                            getFirebase.readFireBaseData(fromPath: "채용공지")
                            noticeTypeSelect="채용공지"
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                isActive=true
                                searchingWord = false
                            }
                        }.foregroundColor(.black).padding(10)
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
    @State private var isActiveSearchView = false
    @State private var isActiveContentView = false
    @State private var isActiveConvenienceView = false
    @State private var isHomeButtonDisabled = false  // 추가된 State 변수
    var body: some View {
        HStack(spacing:100) {
            VStack{
                NavigationLink(destination: SearchView().navigationBarBackButtonHidden(true), isActive: $isActiveSearchView) {
                    Button(action: {
                        isActiveSearchView = true
                    }) {
                        Image(systemName:"plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30).foregroundColor(.cyan)
                    }
                }
                Text("키워드").font(Font(medium15))
            }
            VStack{
                NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true), isActive: $isActiveContentView) {
                    Button(action: {
                        isHomeButtonDisabled = true  // 버튼을 비활성화
                        getFirebase.getMyIDData()
                        getFirebase.readFireBaseData(fromPath: noticeTypeSelect)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            isActiveContentView = true
                            searchingWord=false
                            isHomeButtonDisabled = false  // 1초 후에 버튼을 다시 활성화
                        }
                    }) {
                        Image(systemName:"house.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30).foregroundColor(.cyan)
                    }.disabled(isHomeButtonDisabled)
                }
                Text("홈").font(Font(medium15))
            }
            VStack {
                NavigationLink(destination: ConvenienceView().navigationBarBackButtonHidden(true), isActive: $isActiveConvenienceView) {
                    Button(action: {
                        isActiveConvenienceView = true
                    }) {
                        Image(systemName:"folder.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30).foregroundColor(.cyan)
                    }
                }
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
