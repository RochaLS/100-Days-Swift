//
//  DetailViewController.swift
//  Project7
//
//  Created by Lucas Rocha on 2020-08-17.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var webview: WKWebView!
    var detailItem: Petition?
    
    override func loadView() {
        super.loadView()
        
        webview = WKWebView()
        view = webview
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let detailItem = detailItem else { return }
        
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 150%; } </style>
        </head>
        <body>
        <h2>\(detailItem.title)</h2>
        \(detailItem.body)
        </body>
        </html>
        """
        
        webview.loadHTMLString(html, baseURL: nil)
    }
    
}
