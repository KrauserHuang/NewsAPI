//
//  DetailViewController.swift
//  NewsAPI
//
//  Created by Tai Chin Huang on 2021/9/15.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var articleURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let url = URL(string: articleURL!) else {
            fatalError("Fail to load URL")
        }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

extension DetailViewController: WKNavigationDelegate {

}
