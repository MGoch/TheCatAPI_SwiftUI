//
//  TheCatApi.swift
//  Cat App
//
//  Created by administrator on 27.09.21.
//

import Foundation
import UIKit

class CatAPIService: ObservableObject {
    
    @Published var cats = [Cat]()
    
    /// Sammelt alle Daten der verschiedenen Rassen der "thecatapi"
    
    init() {
        
        fetchCats()
    }
    
    func fetchCats() {
            
        guard let url = URL(string: "https://api.thecatapi.com/v1/breeds") else { return}
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
                
            if let data = data {
            
                do {
                
                    let decoder = JSONDecoder()
                    let catsData = try decoder.decode([Cat].self, from: data)
                    
                    DispatchQueue.main.async {
                        
                        self.cats = catsData
                    }
                } catch let error {
                    
                    print(error)
                }
            }
       }
        
        dataTask.resume()
    }
}
