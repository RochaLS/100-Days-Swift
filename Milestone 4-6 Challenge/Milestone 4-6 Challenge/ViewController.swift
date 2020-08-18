//
//  ViewController.swift
//  Milestone 4-6 Challenge
//
//  Created by Lucas Rocha on 2020-08-15.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var items = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Shopping List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAlert))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clear))
        let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareList))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbarItems = [space, share, space]
        navigationController?.isToolbarHidden = false
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
    }
    
    func add(_ item: String) {
        let indexPath = IndexPath(row: 0, section: 0)
        items.insert(item, at: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
    }
    
    @objc func showAlert() {
        let ac = UIAlertController(title: "Add Item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let addItemAction = UIAlertAction(title: "Add", style: .default) { [weak self, weak ac] _ in
            if let item = ac?.textFields?[0].text {
                self?.add(item.capitalized)
            }
            
        }
        
        ac.addAction(addItemAction)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    @objc func clear() {
        items.removeAll()
        tableView.reloadData()
    }
    
    @objc func shareList() {
        if !items.isEmpty {
            let list = items.joined(separator: "/n") // Separating array forming one big string separated by /n
            let activityVC = UIActivityViewController(activityItems: [list], applicationActivities: [])
            present(activityVC, animated: true  )
        }
        
    }
}

