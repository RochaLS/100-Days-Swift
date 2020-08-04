//
//  DetailViewController.swift
//  Project1
//
//  Created by Lucas Rocha on 2020-08-03.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet var imageView: UIImageView!
    var selectedImage: (name: String?, position: Int?)
    var totalNumOfPictures: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let position = selectedImage.position {
            title = "Picture \(position) of \(totalNumOfPictures!)"
        }
        
        navigationItem.largeTitleDisplayMode = .never
        
        
        // Do any additional setup after loading the view.
        if let imageToLoad = selectedImage.name {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
