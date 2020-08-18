//
//  ViewController.swift
//  Project7
//
//  Created by Lucas Rocha on 2020-08-17.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Petitions"
        navigationItem.leftBarButtonItems = [UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(showFilterAlert)), UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(getData))]
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredits))
        
        getData()
        
        
    }
    
    @objc func getData() {
        var urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                // we're OK to parse!
                parse(json: data)
                return
            }
        }
        showError()
    }
    
    func parse(json: Data) {
        let jsonDecoder = JSONDecoder()
        
        // Converting JSON to type petitions
        if let jsonPetitions = try? jsonDecoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    func filter(by text: String) {
        
        getData() // Get data to start filtering
        
        for petition in petitions {
            if petition.title.contains(text) || petition.body.contains(text) {
                filteredPetitions.append(petition)
            }
        }
        petitions = filteredPetitions
        tableView.reloadData()
    }
    
    
    func showError() {
        let ac = UIAlertController(title: "Loading Error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func showCredits() {
        let ac = UIAlertController(title: "Credits", message: "All this data comes from the: We The People API of the Whitehouse ", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func showFilterAlert() {
        let ac = UIAlertController(title: "Filter by text", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let filterAction = UIAlertAction(title: "Filter", style: .default) { [weak self, weak ac] _ in
            
            if let text = ac?.textFields?[0].text {
                self?.filter(by: text)
            }
        }
        
        ac.addAction(filterAction)
        present(ac, animated: true)
    }
    
    
    
    
}

extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = petitions[indexPath.row].title
        cell.detailTextLabel?.text = petitions[indexPath.row].body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

