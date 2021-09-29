//
//  TheCatApi.swift
//  Cat App
//
//  Created by Maximilian Goch on 27.09.21.
//

import Foundation

@MainActor
class CatAPIService: ObservableObject {
    
    @Published var cats: [Cat] = []

    /// Sammelt alle Daten der verschiedenen Rassen der "thecatapi"
    
    func fetchCats() async {
        
        let url = URL(string: "https://api.thecatapi.com/v1/breeds")!
        let urlSession = URLSession.shared

        do {
            let (data, _) = try await urlSession.data(from: url)
            self.cats = try JSONDecoder().decode([Cat].self, from: data)
        }
        catch {
            debugPrint("Error loading \(url): \(String(describing: error))")
        }
    }
    
//    func fetchCats() {
//
//        guard let url = URL(string: "https://api.thecatapi.com/v1/breeds") else { return}
//
//        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
//
//            if let data = data {
//
//                do {
//
//                    let decoder = JSONDecoder()
//                    let catsData = try decoder.decode([Cat].self, from: data)
//
//                    DispatchQueue.main.async {
//
//                        self.cats = catsData
//                    }
//                } catch let error {
//
//                    print(error)
//                }
//            }
//       }
//
//        dataTask.resume()
//    }
}
