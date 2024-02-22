//
//  WebViewController.swift
//  Dikshatek Test
//
//  Created by Arya Ilham on 22/02/24.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet weak var webView: WKWebView!
    
    var destination: String?
    
    static func createModule(destination: String) -> WebViewController {
        let controller = WebViewController(nibName: "WebViewController", bundle: nil)
        controller.destination = destination
        controller.hidesBottomBarWhenPushed = true
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        self.title = "Article"
        webView.navigationDelegate = self
        
        if let destination = destination, let destinationURL = URL(string: destination) {
            webView.load(URLRequest(url: destinationURL))
        }
    }
}
