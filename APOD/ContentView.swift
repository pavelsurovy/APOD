//
//  ContentView.swift
//  APOD
//
//  Created by Palino on 16/04/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var astroResult = [APODModel]()
    
    var body: some View {
        ScrollView {
            Text(astroResult.first?.title ?? "...")
                .font(.title)
                .padding(.top, 30)
            
            ZStack {
                AsyncImage(url: URL(string: astroResult.first?.url ?? "...")) { image in
                    image.resizable()
                        .scaledToFit()
                } placeholder: {
                    Color.gray
                        .frame(height: 300)
                        .opacity(0.1)
                }
                .padding(.top, 20)
                
                VStack {
                    Spacer()
                    
                    HStack {
                        
                        Spacer()
                        
                        Text(astroResult.first?.copyright ?? "...")
                            .font(.caption)
                            .padding(15)
                            .foregroundColor(.white)
                            .background(.black).opacity(0.5)
                    }
                }
            }
            
            VStack(alignment: .leading) {
                Text(astroResult.first?.explanation ?? "...")
                    .font(.callout)
                    .padding(.top, 20)
                                    
                HStack {
                    Spacer()
                    
                    Text(astroResult.first?.date ?? "...")
                        .font(.caption2)
                        .padding(.top, 20)
                }

                Spacer()
            }
            .padding(10)
            .frame(maxWidth: .infinity)
            .onAppear {
                loadData()
            }
        }
    }
    
    func loadData() {
        let urlString = "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&count=1"
        
        let url = URL(string: urlString)!
                
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
                        
            guard let data = data else {
                print("Data Error!")
                return
            }
                              
            if let json = try? JSONDecoder().decode([APODModel].self, from: data) {
                astroResult = json
            }
        }
        task.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
