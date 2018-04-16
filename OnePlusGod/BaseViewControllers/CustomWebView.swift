//
//  WebViewController.swift
//  OnePlusGod
//
//  Created by Isaac Zachmann on 4/11/18.
//  Copyright © 2018 Isaac Zachmann. All rights reserved.
//

import UIKit
import WebKit

class CustomWebViewController : UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    let webView = WKWebView();
    let loadingIndicator = UIActivityIndicatorView();
    let errorLabel = UILabel();
    var url : URL? = nil;
    
    init(){
        super.init(nibName: nil, bundle: nil);
        
        webView.uiDelegate = self;
        webView.navigationDelegate = self;
        
        self.view.backgroundColor = .white;
        self.view.addSubview(loadingIndicator);
        
        loadingIndicator.activityIndicatorViewStyle = .gray;
        loadingIndicator.hidesWhenStopped = true;
        
        loadingIndicator.layer.zPosition = 1;
        loadingIndicator.frame.size = CGSize(width: 100, height: 100);
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false;
        loadingIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true;
        loadingIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true;
        
        self.view.addSubview(webView);
        webView.translatesAutoresizingMaskIntoConstraints = false;
        webView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        webView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        webView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        loadingIndicator.startAnimating();
        errorLabel.removeFromSuperview();
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        url = webView.url;
        loadingIndicator.stopAnimating();
        errorLabel.removeFromSuperview();
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
        //print("Error loading web content");
        loadingIndicator.stopAnimating();
        
        errorLabel.text = error.localizedDescription + "\nTap here to reload";
        errorLabel.numberOfLines = 0;
        errorLabel.textAlignment = .center;
        
        //label.frame.size = CGSize(width: 100, height: 100);
        self.view.backgroundColor = .white;
        self.view.addSubview(errorLabel);
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false;
        errorLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -50).isActive = true;
        errorLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true;
        errorLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true;
        
        errorLabel.isUserInteractionEnabled = true;
        let tapper = UITapGestureRecognizer(target: self, action: #selector(reload));
        errorLabel.addGestureRecognizer(tapper);
    }
    
    @objc func reload(){
        errorLabel.removeFromSuperview();
        loadFromURL(url: (url?.absoluteString)!);
    }
    
    func loadFromURL(url: String){
        self.url = URL(string: url);
        webView.load(URLRequest(url: self.url!));
    }
    
}
