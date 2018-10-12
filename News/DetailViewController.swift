//
//  DetailViewController.swift
//  News
//
//  Created by Vitaliy Kurbatov on 13/02/2018.
//  Copyright © 2018 Vitaliy Kurbatov. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var webView: WKWebView!
    
    var articleUrl:String?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        spinner.alpha = 1
        spinner.startAnimating()
        webView.navigationDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if articleUrl != nil {
        
            let url = URL(string: articleUrl!)
            
            guard url != nil else {
                return
            }
            let request = URLRequest(url: url!)
            webView.load(request)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension DetailViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        spinner.stopAnimating()
        spinner.alpha = 0
    }
}
