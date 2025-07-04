//
//  ViewController.swift
//  CookBook
//
//  Created by Теона Магай on 03.07.2025.
//

import UIKit

class ViewController: UIViewController {
    
    var foods: [Food] = []
    
    let storage = FoodStorage()
    
    lazy var tableView: UITableView = {
        $0.dataSource = self
        $0.register(FoodCell.self, forCellReuseIdentifier: FoodCell.reuseID)
        $0.separatorStyle = .none
        return $0
    }(UITableView(frame: view.frame, style: .plain))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foods = storage.load()
        
        view.addSubview(tableView)
        navigationItem.title = "Cook Book"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           foods = FoodStorage.shared.load()
           tableView.reloadData()
       }

    
    @objc func addTapped() {
        let vc = AddViewController()
        vc.delegate = self
        navigationController?.pushViewController(AddViewController(), animated: true)
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: FoodCell.reuseID, for: indexPath) as? FoodCell {
            
            let food = foods[indexPath.row]
            cell.setupCell(food: food)
            cell.selectionStyle = .none
            
            cell.onButtonTap = { [weak self] in
                let descriptionVC = DescriptionViewController()
                descriptionVC.food = food
                self?.navigationController?.pushViewController(descriptionVC, animated: true)
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
}

extension ViewController: AddFoodDelegate {
    func didAddFood(_ food: Food) {
        foods.append(food)
        storage.save(foods)
        tableView.reloadData()
    }
}
