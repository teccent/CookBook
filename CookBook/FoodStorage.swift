//
//  FoodStorage.swift
//  CookBook
//
//  Created by Теона Магай on 04.07.2025.
//

import Foundation

class FoodStorage {
    static let shared = FoodStorage()
    private let key = "savedFoods"
    
    func save(_ foods: [Food]) {
        if let data = try? JSONEncoder().encode(foods) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    func load() -> [Food] {
        if let data = UserDefaults.standard.data(forKey: key),
           let foods = try? JSONDecoder().decode([Food].self, from: data) {
            return foods
        }
        return []
    }
}
