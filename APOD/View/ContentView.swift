//
//  ContentView.swift
//  APOD
//
//  Created by Palino on 16/04/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var contentModel = ContentViewModel()
    
    var body: some View {
        ScrollView {
                titleView
            
            ZStack {
                imageView
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        copyrightView
                    }
                }
            }
            
            VStack {
                explanationView
                                    
                HStack {
                    Spacer()
                    
                    dateView
                }
                
                Spacer()
            }
            .padding(10)
            .onAppear {
                contentModel.loadData()
            }
        }
    }
}

extension ContentView {
    private var titleView: some View {
        Text(contentModel.astroResult.first?.title ?? "Astronomy Picture of the Day")
            .font(.title)
            .bold()
            .padding(.top, 30)
            .frame(maxWidth: .infinity, alignment: .center)
            .multilineTextAlignment(.center)
    }
    
    private var imageView: some View {
        AsyncImage(url: URL(string: contentModel.astroResult.first?.url ?? "...")) { image in
            image.resizable()
                .scaledToFit()
        } placeholder: {
            Color.gray
                .frame(height: 300)
                .opacity(0.1)
        }
        .padding(.top, 20)
    }
    
    @ViewBuilder
    private var copyrightView: some View {
        if let copy = contentModel.astroResult.first?.copyright {
            Text(copy)
                .font(.caption)
                .padding(15)
                .foregroundColor(.white)
                .background(.black).opacity(0.5)
        }
    }
    
    private var explanationView: some View {
        Text(contentModel.astroResult.first?.explanation ?? "...")
            .font(.callout)
            .padding(.top, 20)
            .lineSpacing(5)
    }
    
    private var dateView: some View {
        Text(contentModel.astroResult.first?.date ?? "YYYY-MM-DD")
            .font(.caption2)
            .padding(.top, 20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
