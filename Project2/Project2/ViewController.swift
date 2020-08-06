//
//  ViewController.swift
//  Project2
//
//  Created by Lucas Rocha on 2020-08-04.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionCounter = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        
        if score < 0 {
            score = 0
        }
        
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        correctAnswer = Int.random(in: 0...2)
        title = "\(countries[correctAnswer].uppercased()) | Question: \(questionCounter)"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score", style: .plain, target: self, action: #selector(scoreButtonTapped))
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var message: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            message = "Your score is \(score)"
        } else {
            title = "Wrong"
            message = "That's the flag of \(countries[sender.tag].capitalized)! | Score: \(score)"
            score -= 1
        }
        
        if questionCounter >= 10 {
            title = "Game completed!"
            message = "You've completed the game! Your score: \(score)"
            questionCounter = 1
        }
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
        
        questionCounter += 1
    }
    
    @objc func scoreButtonTapped() {
        let alertVC =  UIAlertController(title: "Your score is \(score)", message: nil, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Nice!", style: .default, handler: nil))
        
        present(alertVC, animated: true)
    }
    
}

