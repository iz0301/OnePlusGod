//
//  About.swift
//  OnePlusGod
//
//  Created by Isaac Zachmann on 3/20/18.
//  Copyright © 2018 Isaac Zachmann. All rights reserved.
//

import UIKit

class Donate : CustomWebViewController {
    override init(){
        super.init();
        self.title = "Donate";
        loadFromURL(url: "https://oneplusgod.givingfuel.com/ministry-support");
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    /*override func didReceiveMemoryWarning() {
        self.view = UIView();
    }*/
}
