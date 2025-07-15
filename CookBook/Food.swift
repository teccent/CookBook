//
//  Food.swift
//  CookBook
//
//  Created by Теона Магай on 03.07.2025.
//

import Foundation

struct Food: Codable {
    let name: String
    let ingredients: String
    let recipe: String
    let image: String
    let isSystemImage: Bool
}
