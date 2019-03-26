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
        super.viewDidLoad();
        refreshControl?.endRefreshing();
        tableView.rowHeight = UITableView.automaticDimension;
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

    var customImageView = UIImageView();
    var customLabel = UILabel();
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: .default, reuseIdentifier: "Option");
        
        customLabel.numberOfLines = 0;
        customLabel.lineBreakMode = .byWordWrapping;
        
        customImageView.contentMode = .scaleToFill;
        customImageView.clipsToBounds = true;
        
        accessoryType = .disclosureIndicator;
        
        contentView.addSubview(customImageView);
        contentView.addSubview(customLabel);
        
        customImageView.translatesAutoresizingMaskIntoConstraints = false;
        customLabel.translatesAutoresizingMaskIntoConstraints = false;
        
        customImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true;
        customImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true;
        customImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true;
        
        customImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true;
        customImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true;
        
        customLabel.leftAnchor.constraint(equalTo: customImageView.rightAnchor, constant: 10).isActive = true;
        customLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true;
        customLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true;
        
        layoutSubviews();
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    func prepareToShow(from: OptionListItem){
        customLabel.text = from.title;
        customImageView.image = from.image;
        if(from.image == nil){
            customImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true;
            customImageView.widthAnchor.constraint(equalToConstant: 0).isActive = true;
        } else {
            customImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true;
            customImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true;
        }
        layoutSubviews();
    }
}

struct OptionListItem {
    var image : UIImage?;
    var title : String;
    var toController : UIViewController?;
}
