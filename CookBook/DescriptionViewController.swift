//
//  DescriptionViewController.swift
//  CookBook
//
//  Created by Теона Магай on 04.07.2025.
//

import UIKit

class DescriptionViewController: UIViewController {
    var food: Food?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = food?.name
        
        setupUI()
    }
    
    private func setupUI() {
        guard let food = food else { return }
        
        let foodImage: UIImageView = {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.layer.cornerRadius = 30
            $0.heightAnchor.constraint(equalToConstant: 140).isActive = true
            $0.contentMode = .scaleAspectFit
            $0.clipsToBounds = true
            $0.image = UIImage(systemName: food.image)
            $0.tintColor = .systemOrange
            return $0
        }(UIImageView())
        
        let ingredientsTextView: UITextView = {
            $0.isEditable = false
            $0.isScrollEnabled = false
            $0.text = food.ingredients
            $0.font = UIFont.systemFont(ofSize: 16)
            $0.textColor = .black
            $0.backgroundColor = .cellBG
            $0.layer.cornerRadius = 30
            $0.clipsToBounds = true
            $0.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            $0.translatesAutoresizingMaskIntoConstraints = false
            return $0
        }(UITextView())
        
        
        let recipeTextView: UITextView = {
            $0.isEditable = false
            $0.isScrollEnabled = false
            $0.text = food.recipe
            $0.font = UIFont.systemFont(ofSize: 16)
            $0.textColor = .black
            $0.backgroundColor = .cellBG
            $0.layer.cornerRadius = 30
            $0.clipsToBounds = true
            $0.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            $0.translatesAutoresizingMaskIntoConstraints = false
            return $0
        }(UITextView())
        
        view.addSubview(foodImage)
        view.addSubview(ingredientsTextView)
        view.addSubview(recipeTextView)
        
        NSLayoutConstraint.activate([
            foodImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            foodImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            foodImage.widthAnchor.constraint(equalToConstant: 140),
            foodImage.heightAnchor.constraint(equalTo: foodImage.widthAnchor),

            ingredientsTextView.topAnchor.constraint(equalTo: foodImage.bottomAnchor, constant: 20),
            ingredientsTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            ingredientsTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            recipeTextView.topAnchor.constraint(equalTo: ingredientsTextView.bottomAnchor, constant: 20),
            recipeTextView.leadingAnchor.constraint(equalTo: ingredientsTextView.leadingAnchor),
            recipeTextView.trailingAnchor.constraint(equalTo: ingredientsTextView.trailingAnchor),
            recipeTextView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -20)
        ])
    }
}
