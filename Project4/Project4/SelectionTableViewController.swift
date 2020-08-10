//
//  SelectionTableViewController.swift
//  Project4
//
//  Created by Lucas Rocha on 2020-08-10.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class SelectionTableViewController: UITableViewController {
    
    var websites = ["apple.com", "hackingwithswift.com", "playruneterra.com"]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Website Selection"

    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return websites.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Website", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = websites[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Browser") as? ViewController {
            vc.websites = websites
            vc.selectedWebsite = websites[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }


}
