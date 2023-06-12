//
//  ConvenienceView.swift
//  appUI
//
//  Created by 김나훈 on 2023/04/27.
//

import SwiftUI
import PDFKit
import WebKit

struct PDFViewer: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        pdfView.document = PDFDocument(url: url)
        return pdfView
    }
    
    func updateUIView(_ pdfView: PDFView, context: Context) {
        // Update the view if needed
    }
}



struct PDFSelectionView: View {
    
    let pdfNames = ["2016", "2017", "2018", "2019", "2020", "2021", "2022", "2023"]
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                ForEach(pdfNames, id: \.self) { pdfName in
                    if let pdfURL = Bundle.main.url(forResource: pdfName, withExtension: "pdf") {
                        NavigationLink(destination: PDFViewer(url: pdfURL)) {
                            Text(pdfName)
                                .frame(width: 100, height: 30)
                                .background(Color.cyan)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
            }
        }
    }
}
struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: UIViewRepresentableContext<WebView>) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
        // Update the view if needed
    }
}

struct ConvenienceView: View {
    @State private var showSafari = false
    
    let ictURL = URL(string: "https://cms3.koreatech.ac.kr/dice/655/subview.do?enc=Zm5jdDF8QEB8JTJGYmJzJTJGZGljZSUyRjI2NSUyRmFydGNsTGlzdC5kbyUzRg%3D%3D")
    var body: some View {
        VStack {
            Text("   KoreaTech ICT")
                .font(.system(size: 25))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(UIColor.systemCyan))
            NavigationView {
                VStack(spacing:30) {
                    
                    HStack {
                        Image(systemName: "info.circle").resizable()
                            .frame(width: 70, height: 70) .foregroundColor(Color(UIColor(named:"Color1")!))
                        NavigationLink(destination: Bundle.main.url(forResource: "information", withExtension: "pdf").map(PDFViewer.init)) {
                            Text("app 정보")
                                .frame(width: 220, height: 50)
                                .background(Color(UIColor(named:"Color1")!))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        
                    }
                    HStack{
                        Image(systemName: "newspaper.circle").resizable()
                            .frame(width: 70, height: 70).foregroundColor(Color(UIColor(named:"Color2")!))
                        NavigationLink(destination: WebView(url: ictURL!)) {
                            Text("학과 공지")
                                .frame(width: 220, height: 50)
                                .background(Color(UIColor(named:"Color2")!))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                   
                    HStack {
                        
                        Image(systemName: "graduationcap.circle").resizable()
                            .frame(width: 70, height: 70).foregroundColor(Color(UIColor(named:"Color3")!))
                        NavigationLink(destination: PDFSelectionView()) {
                            Text("대학요람")
                                .frame(width: 220, height: 50)
                                .background(Color(UIColor(named:"Color3")!))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        
                    }
                    HStack {
                        Image(systemName: "photo.circle").resizable()
                            .frame(width: 70, height: 70).foregroundColor(Color(UIColor(named:"Color4")!))
                        NavigationLink(destination: Bundle.main.url(forResource: "professor", withExtension: "pdf").map(PDFViewer.init)) {
                            Text("교수진")
                                .frame(width: 220, height: 50)
                                .background(Color(UIColor(named:"Color4")!))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        
                    }
                    HStack{
                        Image(systemName: "person.circle").resizable()
                            .frame(width: 70, height: 70).foregroundColor(Color(UIColor(named:"Color5")!))
                        NavigationLink(destination: Bundle.main.url(forResource: "ictTeam", withExtension: "pdf").map(PDFViewer.init)) {
                            Text("학생회 조직도")
                                .frame(width: 220, height: 50)
                                .background(Color(UIColor(named:"Color5")!))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    
                    
                }
            }
            
            
            
        }
        
        ButtonItem()
    }
    
}

struct FullScreenImage: View {
    var image: Image
    var body: some View {
        image
            .resizable()
            .scaledToFit()
            .navigationBarBackButtonHidden(true)
    }
}

struct ConvenienceView_Previews: PreviewProvider {
    static var previews: some View {
        ConvenienceView()
    }
}
