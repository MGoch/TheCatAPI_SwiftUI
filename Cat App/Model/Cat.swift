//
//  Cat.swift
//  Cat App
//
//  Created by Maximilian Goch on 27.09.21.
//

import Foundation
import SwiftUI

struct Cat: Codable, Identifiable {
    var name: String
    var id: String
    var origin: String
    var description: String
    var image: CatImage?

}
