//
//  TheCatApi.swift
//  Cat App
//
//  Created by administrator on 27.09.21.
//

import Foundation
import UIKit

class CatAPIService {
    
    /// Sammelt alle Daten der verschiedenen Rassen der "thecatapi"
    
    func getCats(completion:@escaping ([Cat]) -> ()) {
            
        guard let url = URL(string: "https://api.thecatapi.com/v1/breeds") else { return}
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
        
            if let data = data {
            
                do {
                
                    let decoder = JSONDecoder()
                    let catsData = try decoder.decode([Cat].self, from: data)
                
                    completion(catsData)
                } catch let error {
                    
                    print(error)
                }
            }
       }
        
        dataTask.resume()
    }
}
