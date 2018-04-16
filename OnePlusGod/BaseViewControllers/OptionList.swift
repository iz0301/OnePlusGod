//
//  Request.swift
//  OnePlusGod
//
//  Created by Isaac Zachmann on 4/6/18.
//  Copyright © 2018 Isaac Zachmann. All rights reserved.
//

import UIKit

class OptionList : UITableViewController {
    
    var options : [OptionListItem] = [];
    
    convenience init(){
        self.init(nibName: nil, bundle: nil);
    }
    
    override func viewDidLoad() {
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.separatorInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0);
        tableView.register(OptionListItemCell.self, forCellReuseIdentifier: "Option");
        tableView.reloadData();
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Option", for: indexPath);
        (cell as! OptionListItemCell).prepareToShow(from: options[indexPath.item]);
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(options[indexPath.item].toController != nil){
            self.navigationController?.pushViewController(options[indexPath.item].toController!, animated: true);
        }
    }
}

class OptionListItemCell : UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: .default, reuseIdentifier: "Option");
        textLabel?.numberOfLines = 0;
        accessoryType = .disclosureIndicator;
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    func prepareToShow(from: OptionListItem){
        imageView?.image = from.image;
        textLabel?.text = from.title;
    }
}

struct OptionListItem {
    var image : UIImage?;
    var title : String;
    var toController : UIViewController?;
}
