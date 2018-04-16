//
//  Menu.swift
//  OnePlusGod
//
//  Created by Isaac Zachmann on 3/19/18.
//  Copyright © 2018 Isaac Zachmann. All rights reserved.
//


import UIKit

// A base UIViewController that is to be extened by other views controllers, the view
class NavBar : UIViewController {
    
    func setMenuBar(){
       self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(menuButtonTapped));
        self.view.backgroundColor = UIColor.blue;
    }
    
    @objc func menuButtonTapped() {
        AppDelegate.navController.topViewController.move
        AppDelegate.navController.pushViewController(Menu(), animated: true);
    }
    
};

class Menu : UIViewController {
    
    convenience init(){
        self.init(nibName: nil, bundle:nil);
        self.title = "Menu";
        self.view.backgroundColor = UIColor.red;
    }
    
}
