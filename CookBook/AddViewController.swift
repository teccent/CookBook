//
//  AddViewController.swift
//  CookBook
//
//  Created by Теона Магай on 03.07.2025.
//

import UIKit

class AddViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    weak var delegate: AddFoodDelegate?

    let nameField: UITextView = {
        $0.text = "Название"
        $0.textColor = .lightGray
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.layer.cornerRadius = 30
        $0.backgroundColor = .cellBG
        $0.clipsToBounds = true
        $0.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return $0
    }(UITextView())
    
    let ingredientsField: UITextView = {
        $0.text = "Ингредиенты"
        $0.textColor = .lightGray
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.layer.cornerRadius = 30
        $0.backgroundColor = .cellBG
        $0.clipsToBounds = true
        $0.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return $0
    }(UITextView())
    
    let recipeField: UITextView = {
        $0.text = "Рецепт"
        $0.textColor = .lightGray
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.layer.cornerRadius = 30
        $0.backgroundColor = .cellBG
        $0.clipsToBounds = true
        $0.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return $0
    }(UITextView())
    
    let saveButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        $0.backgroundColor = .btnBG
        $0.layer.cornerRadius = 20
        $0.setTitle("Сохранить", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        return $0
    }(UIButton(type: .system))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Добавить рецепт"
        
        nameField.delegate = self
        ingredientsField.delegate = self
        recipeField.delegate = self
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        
        setupLayout()
        registerForKeyboardNotifications()
    }
    
    func setupLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        // поля
        [nameField, ingredientsField, recipeField, saveButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            nameField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameField.heightAnchor.constraint(equalToConstant: 60),
            
            ingredientsField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20),
            ingredientsField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            ingredientsField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            ingredientsField.heightAnchor.constraint(equalToConstant: 100),
            
            recipeField.topAnchor.constraint(equalTo: ingredientsField.bottomAnchor, constant: 20),
            recipeField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            recipeField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            recipeField.heightAnchor.constraint(equalToConstant: 150),
            
            saveButton.topAnchor.constraint(equalTo: recipeField.bottomAnchor, constant: 30),
            saveButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            saveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),
            saveButton.widthAnchor.constraint(equalToConstant: 200)
            // важно!
        ])
    }
    
    @objc func saveTapped() {
        view.endEditing(true)

        let newFood = Food(
            name: nameField.text ?? "",
            ingredients: ingredientsField.text ?? "",
            recipe: recipeField.text ?? "",
            image: "fork.knife.circle" // или другое изображение
        )

        var saved = FoodStorage.shared.load()
        saved.append(newFood)
        FoodStorage.shared.save(saved)

        navigationController?.popViewController(animated: true)
    }

    
    // MARK: - Keyboard Handling
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }

        scrollView.contentInset.bottom = keyboardFrame.height + 20
    }

    @objc func keyboardWillHide(notification: Notification) {
        scrollView.contentInset.bottom = 0
    }
}

// MARK: - Extension

extension AddViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = ""
            textView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            if textView == ingredientsField {
                textView.text = "Ингредиенты"
            } else if textView == recipeField {
                textView.text = "Рецепт"
            } else if textView == nameField {
                textView.text = "Название"
            }
            textView.textColor = .lightGray
        }
    }
}

protocol AddFoodDelegate: AnyObject {
    func didAddFood(_ food: Food)
}
