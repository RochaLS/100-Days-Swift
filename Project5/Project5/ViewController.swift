//
//  ViewController.swift
//  Project5
//
//  Created by Lucas Rocha on 2020-08-11.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var allWords = [String]()
    var usedWords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame))
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) { // try? gives me nil if it fails
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        
        startGame()
    }
    
    @objc func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    @objc func promptAnswer() {
        let ac = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        // If we don't use weak here, swift will capture the current VC and the alertVC, causing a strong reference cycle.
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
            
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true, completion: nil)
    }
    
    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()
        
        if !isTooShort(word: lowerAnswer) {
            if isPossible(word: lowerAnswer) {
                if isOriginal(word: lowerAnswer) {
                    if isReal(word: lowerAnswer) {
                        usedWords.insert(lowerAnswer, at: 0)
                        
                        let indexPath = IndexPath(row: 0, section: 0)
                        tableView.insertRows(at: [indexPath] , with: .automatic)
                        
                        return
                    } else {
                        showErrorMessage(title: "Word not recognised", message: "You can't just make them up, you know!")
                    }
                } else {
                    showErrorMessage(title: "Word already used or same as title" , message: "Be more original!")
                    
                }
                
            } else {
                guard let title = title?.lowercased() else { return }
                showErrorMessage(title: "Word not possible" , message: "You can't spell that word from \(title)")
            }
        } else {
            showErrorMessage(title: "Word too short" , message: "You can do better than that!")
            
        }
    }
    
    
    func isReal(word: String) -> Bool {
        // Checking to see if word is missspelled and basically returning true if there isn't a spelling error or false if there is meaning that it's not a real word.
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        
        // If letter exists in the word that the user trying to guess remove this letter from the title word (temp word) to avoid the possiblity of the user using it twice.
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        if word.lowercased() == title {
            return false
        }
        
        return !usedWords.contains(word)
    }
    
    func isTooShort(word: String) -> Bool {
        if word.count < 3 {
            return true
        }
        
        return false
    }
    
    func showErrorMessage(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    
    
}



