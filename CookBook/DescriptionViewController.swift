//
//  DescriptionViewController.swift
//  CookBook
//
//  Created by Теона Магай on 04.07.2025.
//

import UIKit

class DescriptionViewController: UIViewController {
    var food: Food?
    
    let imageView = UIImageView()
    let nameTextView = UITextView()
    let ingredientsTextView = UITextView()
    let recipeTextView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = food?.name
        
        setupUI()
        updateUI()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: #selector(editTapped)
        )
    }
    
//    private func setupUI() {
//        guard let food = food else { return }
//        
//        let foodImage: UIImageView = {
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            $0.layer.cornerRadius = 30
//            $0.heightAnchor.constraint(equalToConstant: 140).isActive = true
//            $0.contentMode = .scaleAspectFit
//            $0.clipsToBounds = true
//            $0.image = UIImage(systemName: food.image)
//            $0.tintColor = .systemOrange
//            return $0
//        }(UIImageView())
//        
//        if food.isSystemImage {
//            foodImage.image = UIImage(systemName: food.image)
//            foodImage.tintColor = .systemOrange
//            foodImage.contentMode = .scaleAspectFit
//        } else {
//            let imagePath = getDocumentsDirectory().appendingPathComponent(food.image).path
//            foodImage.image = UIImage(contentsOfFile: imagePath)
//            foodImage.contentMode = .scaleAspectFill
//        }
//        
//        let ingredientsTextView: UITextView = {
//            $0.isEditable = false
//            $0.isScrollEnabled = false
//            $0.text = food.ingredients
//            $0.font = UIFont.systemFont(ofSize: 16)
//            $0.textColor = .black
//            $0.backgroundColor = .cellBG
//            $0.layer.cornerRadius = 30
//            $0.clipsToBounds = true
//            $0.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            return $0
//        }(UITextView())
//        
//        
//        let recipeTextView: UITextView = {
//            $0.isEditable = false
//            $0.isScrollEnabled = false
//            $0.text = food.recipe
//            $0.font = UIFont.systemFont(ofSize: 16)
//            $0.textColor = .black
//            $0.backgroundColor = .cellBG
//            $0.layer.cornerRadius = 30
//            $0.clipsToBounds = true
//            $0.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            return $0
//        }(UITextView())
//        
//        view.addSubview(foodImage)
//        view.addSubview(ingredientsTextView)
//        view.addSubview(recipeTextView)
//        
//        NSLayoutConstraint.activate([
//            foodImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            foodImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            foodImage.widthAnchor.constraint(equalToConstant: 140),
//            foodImage.heightAnchor.constraint(equalTo: foodImage.widthAnchor),
//
//            ingredientsTextView.topAnchor.constraint(equalTo: foodImage.bottomAnchor, constant: 20),
//            ingredientsTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            ingredientsTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//
//            recipeTextView.topAnchor.constraint(equalTo: ingredientsTextView.bottomAnchor, constant: 20),
//            recipeTextView.leadingAnchor.constraint(equalTo: ingredientsTextView.leadingAnchor),
//            recipeTextView.trailingAnchor.constraint(equalTo: ingredientsTextView.trailingAnchor),
//            recipeTextView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -20)
//        ])
//    }
    
    private func setupUI() {
           imageView.translatesAutoresizingMaskIntoConstraints = false
           imageView.layer.cornerRadius = 30
           imageView.clipsToBounds = true
           imageView.contentMode = .scaleAspectFit
           view.addSubview(imageView)
        
        let ingredientsTitleLabel: UILabel = {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.text = "Ингредиенты"
            $0.font = UIFont.boldSystemFont(ofSize: 18)
            return $0
        }(UILabel())
        view.addSubview(ingredientsTitleLabel)
        
        let recipeTitleLabel: UILabel = {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.text = "Рецепт"
            $0.font = UIFont.boldSystemFont(ofSize: 18)
            return $0
        }(UILabel())
        view.addSubview(recipeTitleLabel)

        ingredientsTextView.isEditable = false
        ingredientsTextView.isScrollEnabled = false
        ingredientsTextView.font = UIFont.systemFont(ofSize: 16)
        ingredientsTextView.textColor = .black
        ingredientsTextView.backgroundColor = .cellBG
        ingredientsTextView.layer.cornerRadius = 30
        ingredientsTextView.clipsToBounds = true
        ingredientsTextView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        ingredientsTextView.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(ingredientsTextView)

        recipeTextView.isEditable = false
        recipeTextView.isScrollEnabled = false
        recipeTextView.font = UIFont.systemFont(ofSize: 16)
        recipeTextView.textColor = .black
        recipeTextView.backgroundColor = .cellBG
        recipeTextView.layer.cornerRadius = 30
        recipeTextView.clipsToBounds = true
        recipeTextView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        recipeTextView.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(recipeTextView)

        NSLayoutConstraint.activate([
                   imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                   imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                   imageView.widthAnchor.constraint(equalToConstant: 140),
                   imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),

                   ingredientsTitleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
                   ingredientsTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

                   
                   ingredientsTextView.topAnchor.constraint(equalTo: ingredientsTitleLabel.bottomAnchor, constant: 20),
                   ingredientsTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                   ingredientsTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                   
                   recipeTitleLabel.topAnchor.constraint(equalTo: ingredientsTextView.bottomAnchor, constant: 20),
                   recipeTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),


                   recipeTextView.topAnchor.constraint(equalTo: recipeTitleLabel.bottomAnchor, constant: 20),
                   recipeTextView.leadingAnchor.constraint(equalTo: ingredientsTextView.leadingAnchor),
                   recipeTextView.trailingAnchor.constraint(equalTo: ingredientsTextView.trailingAnchor),
                   recipeTextView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -20)
               ])
           }

         
    
    private func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func updateUI() {
        guard let food = food else { return }

        nameTextView.text = food.name
        ingredientsTextView.text = food.ingredients
        recipeTextView.text = food.recipe

        if food.isSystemImage {
            imageView.image = UIImage(systemName: food.image)
        } else {
            let path = getDocumentsDirectory().appendingPathComponent(food.image).path
            imageView.image = UIImage(contentsOfFile: path)
        }
    }
    
    @objc func editTapped() {
        guard let food = food else { return }
        
        let editVC = AddViewController()
        // Передаём еду для редактирования
        editVC.configureForEditing(food: food)
        
        editVC.onSave = { [weak self] updatedFood in
               self?.food = updatedFood
               self?.updateUI()
           }
        
        navigationController?.pushViewController(editVC, animated: true)
    }
}


