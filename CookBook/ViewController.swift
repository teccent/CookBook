//
//  ViewController.swift
//  CookBook
//
//  Created by Теона Магай on 03.07.2025.
//

import UIKit

class ViewController: UIViewController {

    let foods = Food.mockData()
    
    lazy var tableView: UITableView = {
        $0.dataSource = self
        $0.register(FoodCell.self, forCellReuseIdentifier: FoodCell.reuseID)
        $0.separatorStyle = .none
        return $0
    }(UITableView(frame: view.frame, style: .plain))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        navigationItem.title = "Cook Book"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    @objc func addTapped() {
        self.navigationController?.pushViewController(AddViewController(), animated: true)
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
            
            return cell
        }
        return UITableViewCell()
    }
    
    
}
