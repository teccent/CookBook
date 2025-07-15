//
//  FoodCell.swift
//  CookBook
//
//  Created by Теона Магай on 03.07.2025.
//

import UIKit

class FoodCell: UITableViewCell{
    
    static let reuseID = "FoodCell"
    
    var onButtonTap: (() -> Void)?
    
   private var foodCellView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 30
        $0.backgroundColor = .cellBG
        return $0
    }(UIView())
    
    private var foodCellImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 30
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .systemOrange
        return $0
    }(UIImageView())
    
    private var foodCellButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        $0.backgroundColor = .btnBG
        $0.layer.cornerRadius = 20
        $0.setTitle("Подробнее", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        
        return $0
    }(UIButton())
    
    private lazy var foodCellHeader = getLabel(font: UIFont.systemFont(ofSize: 20, weight: .bold))
    private lazy var foodCellRecipe = getLabel(font: UIFont.systemFont(ofSize: 16, weight: .medium))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(foodCellView)
        foodCellView.addSubview(foodCellImage)
        foodCellView.addSubview(foodCellHeader)
        foodCellView.addSubview(foodCellRecipe)
        foodCellView.addSubview(foodCellButton)
        
        setupConstraints()
        
        foodCellButton.addTarget(self, action: #selector(cellTapped), for: .touchUpInside)
    }
    
    func setupCell(food: Food) {
        if food.isSystemImage {
            foodCellImage.image = UIImage(systemName: food.image)
            foodCellImage.contentMode = .scaleAspectFit
            foodCellImage.tintColor = .systemOrange
        } else {
            let imagePath = getDocumentsDirectory().appendingPathComponent(food.image).path
            foodCellImage.image = UIImage(contentsOfFile: imagePath)
            foodCellImage.contentMode = .scaleAspectFill
        }

        foodCellImage.layer.cornerRadius = 16
        foodCellImage.clipsToBounds = true
        foodCellHeader.text = food.name
        foodCellRecipe.text = food.recipe
    }
    
    private func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            foodCellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            foodCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            foodCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            foodCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            
            foodCellImage.topAnchor.constraint(equalTo: foodCellView.topAnchor, constant: 20),
               foodCellImage.centerXAnchor.constraint(equalTo: foodCellView.centerXAnchor),  // по центру
               foodCellImage.widthAnchor.constraint(equalToConstant: 140),                  // квадрат
               foodCellImage.heightAnchor.constraint(equalTo: foodCellImage.widthAnchor),
            
            foodCellHeader.topAnchor.constraint(equalTo: foodCellImage.bottomAnchor, constant: 20),
            foodCellHeader.leadingAnchor.constraint(equalTo: foodCellView.leadingAnchor, constant: 36),
            foodCellHeader.trailingAnchor.constraint(equalTo: foodCellView.trailingAnchor, constant: -20),
            
            foodCellRecipe.topAnchor.constraint(equalTo: foodCellHeader.bottomAnchor, constant: 12),
            foodCellRecipe.leadingAnchor.constraint(equalTo: foodCellView.leadingAnchor, constant: 20),
            foodCellRecipe.trailingAnchor.constraint(equalTo: foodCellView.trailingAnchor, constant: -20),
            
            foodCellButton.topAnchor.constraint(equalTo: foodCellRecipe.bottomAnchor, constant: 25),
            foodCellButton.leadingAnchor.constraint(equalTo: foodCellView.leadingAnchor, constant: 20),
            foodCellButton.trailingAnchor.constraint(equalTo: foodCellView.trailingAnchor, constant: -20),
            
            foodCellButton.bottomAnchor.constraint(equalTo: foodCellView.bottomAnchor, constant: -40)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getLabel(font: UIFont) -> UILabel{
        {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.font = font
            $0.numberOfLines = 0
            
            return $0
        }(UILabel())
    }
    
    @objc private func cellTapped() {
        onButtonTap?()
    }
    
    
}
