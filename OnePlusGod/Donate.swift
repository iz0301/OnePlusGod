//
//  About.swift
//  OnePlusGod
//
//  Created by Isaac Zachmann on 3/20/18.
//  Copyright © 2018 Isaac Zachmann. All rights reserved.
//

import UIKit

class Donate : UIViewController {
    init(){
        super.init(nibName: nil, bundle: nil);
        self.title = "Donate";
        //loadFromURL(url: "https://oneplusgod.givingfuel.com/ministry-support");
        
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white;
        
        let donateWords = UILabel();
        donateWords.text = "Please tap below to visit the website and make a donation.";
        donateWords.numberOfLines = 0;
        donateWords.textAlignment = .center;
        
        
        let button = UIButton(type: .custom);
        button.setTitleColor(.blue, for: .normal);
        button.setTitleColor(UIColor(red: 0, green: 0, blue: 1.0, alpha: 0.6), for: .highlighted);
        button.setTitle("Donate", for: .normal);
        button.contentHorizontalAlignment = .center;
        
        self.view.addSubview(donateWords);
        self.view.addSubview(button);
        
        donateWords.translatesAutoresizingMaskIntoConstraints = false;
        donateWords.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -50).isActive = true;
        donateWords.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true;
        donateWords.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -50).isActive = true;
        
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.topAnchor.constraint(equalTo: donateWords.bottomAnchor, constant: 10).isActive = true;
        button.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -50).isActive = true;
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true;
    
        button.addTarget(self, action: #selector(toDonate), for: .touchUpInside);
    }
    
    @objc func toDonate(){
        UIApplication.shared.open(URL(string: "https://oneplusgod.givingfuel.com/ministry-support")!, options: [:], completionHandler: nil);
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    /*override func didReceiveMemoryWarning() {
        self.view = UIView();
    }*/
}
