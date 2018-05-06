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
    let cartURL = "https://www.oneplusgod.org/cart";
    
    @objc func checkout(){
        if(webView.url != URL(string: cartURL)){
            loadFromURL(url: cartURL);
        }
    }
    
    override init(){
        super.init();
        self.title = "OPG Store";
        loadFromURL(url: storeURL);
        webView.scrollView.delegate = self;
        
        webView.allowsBackForwardNavigationGestures = true;
        
        let homeButton = UIButton(type: .custom);
        homeButton.setImage(#imageLiteral(resourceName: "StoreIcon").withRenderingMode(.alwaysTemplate), for: .normal);
        homeButton.tintColor = .white;
        //homeButton.setImage(#imageLiteral(resourceName: "StoreIcon"), for: .selected);
        homeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(home)))
        
        let checkoutButton = UIButton(type: .custom);
        checkoutButton.setImage(#imageLiteral(resourceName: "CheckoutIcon").withRenderingMode(.alwaysTemplate), for: .normal);
        checkoutButton.tintColor = .white;
        checkoutButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(checkout)))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: checkoutButton);
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
