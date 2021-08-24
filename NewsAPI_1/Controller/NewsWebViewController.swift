//
//  NewsWebViewController.swift
//  NewsAPI_1
//
//  Created by Ram on 06/07/21.
//

import UIKit
import WebKit

class NewsWebViewController: UIViewController, WKUIDelegate {
    var webView: WKWebView!
     var newsUrl:String = ""
     var myURL:URL!
     var myRequest:URLRequest!
    override func viewDidLoad() {
       super.viewDidLoad()
        self.navigationController!.isNavigationBarHidden = false
     
    }
     override func viewDidAppear(_ animated: Bool) {
         print(newsUrl)
         webView.load(URLRequest(url: (URL(string: newsUrl) ?? URL(string: "https://www.thehindu.com/"))!))
     }
    
    override func loadView() {
       let webConfiguration = WKWebViewConfiguration()
       webView = WKWebView(frame: .zero, configuration: webConfiguration)
       webView.uiDelegate = self
       view = webView
    }
 }
    
