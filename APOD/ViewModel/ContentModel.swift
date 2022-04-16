//
//  ContentModel.swift
//  APOD
//
//  Created by Palino on 16/04/2022.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var astroResult = [APODModel]()

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
                DispatchQueue.main.async {
                    self.astroResult = json
                }
            }
        }
        task.resume()
    }
    
}
