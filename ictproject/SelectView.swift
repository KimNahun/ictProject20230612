//
//  SelectView.swift
//  appUI
//
//  Created by 김나훈 on 2023/05/01.
//

import SwiftUI

var firebase = FireBaseViewController()
struct SelectView: View {
    @State private var showingContentView = false
    var body: some View {
          VStack {
              VStack(spacing:70){
                  //공지 누르면 그 공지에 따라 다시 파이어베이스에서 글 가져옴
                  //그리고 새로고침
                  //배열에 덮어쓰기
                  Button("일반공지") {
                      firebase.readFireBaseData1()
                      tempTitle = tempTitle1
                      myArray=myArray1
                      showingContentView=true
                      searchingWord=false
                  }.fullScreenCover(isPresented: $showingContentView, content: {
                      ContentView()
                  })
                  Button("장학공지") {
                      firebase.readFireBaseData2()
                      tempTitle = tempTitle2
                      myArray=myArray2
                      showingContentView=true
                      searchingWord=false
                  }.fullScreenCover(isPresented: $showingContentView, content: {
                      ContentView()
                  })
                  
                  Button("학사공지") {
                      firebase.readFireBaseData3()
                      tempTitle = tempTitle3
                      myArray=myArray3
                      showingContentView=true
                      searchingWord=false
                  }.fullScreenCover(isPresented: $showingContentView, content: {
                      ContentView()
                  })
                  
                  Button("채용공지") {
               //       tempTitle = tempTitle3
                      showingContentView=true
                      searchingWord=false
                  }.fullScreenCover(isPresented: $showingContentView, content: {
                      ContentView()
                  })
                  
              }
              Spacer()
              ButtonItem()
              
          }
      }
}



struct SelectView_Previews: PreviewProvider {
    static var previews: some View {
        SelectView()
    }
}
