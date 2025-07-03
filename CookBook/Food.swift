//
//  Food.swift
//  CookBook
//
//  Created by Теона Магай on 03.07.2025.
//

import Foundation

struct Food {
    let name: String
    let description: String
    let image: String
    
    static func mockData() -> [Food] {
        [
            Food(name: "Хлеб", description: "Какой то хлеб", image: "fork.knife.circle"),
            Food(name: "Пицца", description: "Какая то пицца", image: "fork.knife.circle"),
            Food(name: "Запеканка", description: "Какая то запеканка", image: "fork.knife.circle")
        ]
    }
}
