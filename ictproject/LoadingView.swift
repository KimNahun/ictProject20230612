//
//  LoadingView.swift
//  ictproject
//
//  Created by 김나훈 on 2023/05/08.
//

import SwiftUI

//로딩이 된 동안 화면에 출력되는 글
struct LoadingView: View {
    var body: some View {
        VStack {
            
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}

//일부러 딜레이 시키는 view
//파이어베이스에서 데이터를 긁어오는 동안 수행을 지연시키는 역할
struct DelayedView<Content: View>: View {
    let delay: TimeInterval
    let content: () -> Content
    @State private var isShowingContent = false
    
    var body: some View {
        Group {
            if isShowingContent {
                content()
            } else {
                Color.clear
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                            isShowingContent = true
                        }
                    }
            }
        }
    }
}
