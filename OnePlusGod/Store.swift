//
//  Projects.swift
//  OnePlusGod
//
//  Created by Isaac Zachmann on 4/6/18.
//  Copyright © 2018 Isaac Zachmann. All rights reserved.
//

import UIKit
import WebKit

class Store : CustomWebViewController, UIScrollViewDelegate {
    let storeURL = "https://www.oneplusgod.org/store/";
    
    override init(){
        super.init();
        self.title = "OPG Store";
        loadFromURL(url: storeURL);
        webView.scrollView.delegate = self;
        
        webView.allowsBackForwardNavigationGestures = true;
        
        let homeButton = UIButton();
        homeButton.setImage(#imageLiteral(resourceName: "AboutIcon"), for: .normal);
        homeButton.setImage(#imageLiteral(resourceName: "AboutIcon"), for: .selected);
        homeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(home)))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: homeButton);
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        scrollView.pinchGestureRecognizer?.isEnabled = false;
    }
    
    override func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        super.webView(webView, didStartProvisionalNavigation: navigation);
        //if something happened to get out of store
        if(webView.url?.absoluteString.elementsEqual("https://www.oneplusgod.org/"))!{
            home();
        }
    }
    
    override func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        super.webView(webView, didFinish: navigation);
        webView.evaluateJavaScript(
            "document.getElementById('header').remove();document.getElementById('footer').remove();", completionHandler: nil);
    }
    
    @objc func home(){
        if(webView.url != URL(string: storeURL)){
            loadFromURL(url: storeURL);
        }
    }
    
    /*override func didReceiveMemoryWarning() {
        self.view = UIView();
    }*/
    
}
