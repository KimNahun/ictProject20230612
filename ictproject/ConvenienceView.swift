//
//  ConvenienceView.swift
//  appUI
//
//  Created by 김나훈 on 2023/04/27.
//

import SwiftUI
import PDFKit

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
            VStack(spacing: 50) {
                ForEach(pdfNames, id: \.self) { pdfName in
                    if let pdfURL = Bundle.main.url(forResource: pdfName, withExtension: "pdf") {
                        NavigationLink(destination: PDFViewer(url: pdfURL)) {
                            Text(pdfName)
                                .frame(width: 100, height: 30)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
            }
        }
    }
}

struct ConvenienceView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 50) {
                NavigationLink(destination: PDFSelectionView()) {
                    Text("대학요람")
                        .frame(width: 100, height: 30)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                NavigationLink(destination: Bundle.main.url(forResource: "professor", withExtension: "pdf").map(PDFViewer.init)) {
                    Image("image2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                }
                NavigationLink(destination: Bundle.main.url(forResource: "ictTeam", withExtension: "pdf").map(PDFViewer.init)) {
                    Image("image3")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                }
                NavigationLink(destination: FullScreenImage(image: Image("image8"))) {
                    Image("image4")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
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
