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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
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
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("Image not found!")
            return
        }
        let vc = UIActivityViewController(activityItems: [image, selectedImage.name ?? ""], applicationActivities: [])
        // This line of code below tells iOS to anchor the activity view controller to the right bar button item (our share button), but this only has an effect on iPad – on iPhone it's ignored.
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
}
