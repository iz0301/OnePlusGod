//
//  News.swift
//  OnePlusGod
//
//  Created by Isaac Zachmann on 3/17/18.
//  Copyright © 2018 Isaac Zachmann. All rights reserved.
//

import UIKit

class News : UITableViewController, WebImageDelegate {
    
    @objc func toTheWebsite(){
        let alert = UIAlertController(title: "More", message: "For more information, please visit the website.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil));
        alert.addAction(UIAlertAction(title: "Go", style: .default, handler: {action in
            UIApplication.shared.open(URL(string: "https://oneplusgod.org")!, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil);
        }));
        self.present(alert, animated: true, completion: nil);
    }
    
    var newsItems : [NewsItem] = [];
    
    // Set up viewcontroller
    convenience init(){
        self.init(nibName: nil, bundle: nil);
        self.title = "One Plus God";
        let moreInfo = UIButton(type: .infoLight);
        moreInfo.addTarget(self, action: #selector(toTheWebsite), for: .touchUpInside);
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: moreInfo);
        self.view.backgroundColor = .white;
    }
    
    @objc func refreshNewsItems(){
        DispatchQueue.global(qos: .background).async {
            self.newsItems = NewsItem.loadNewsItems(onImageLoad: self);
            DispatchQueue.main.async{
                self.tableView.reloadData();
                self.tableView.refreshControl?.endRefreshing();
            }
        };
    }
    
    override func viewDidLoad() {
        // Set up table:
        self.refreshControl = UIRefreshControl();
        self.refreshControl?.addTarget(self, action: #selector(refreshNewsItems), for: UIControl.Event.valueChanged);
        self.refreshControl?.beginRefreshing();
        
        self.refreshControl?.backgroundColor = .white;
        
        self.tableView.register(NewsCell.self, forCellReuseIdentifier: "Identifier");
        
        self.tableView.allowsSelection = false;
        self.tableView.rowHeight = UITableView.automaticDimension;
        
        self.newsItems.append(NewsItem(title: "Loading...", content: "", media: nil, link: nil));
        
        // load news:
        self.refreshNewsItems();
        //self.view.addSubview(feed);
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator);
        self.didFinishLoadingImages();
    }
    
    // Should return the number of cells
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count;
    }
    
    // Called when the table needs a cell, probably nothing needs changed here. Change stuff in NewsCell classs
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Identifier", for: indexPath as IndexPath);
        
        (cell as! NewsCell).reinit();
        (cell as! NewsCell).contentView.layoutSubviews();
        (cell as! NewsCell).prepareToShow(from: newsItems[indexPath.item]);
        cell.layoutSubviews();
        return cell;
    }
    
    func didFinishLoadingImages() {
        DispatchQueue.main.async {
            for i in 0...(self.tableView.visibleCells.count - 1){
                (self.tableView.visibleCells[i] as! NewsCell).reinit();
                (self.tableView.visibleCells[i] as! NewsCell).contentView.layoutSubviews();
                (self.tableView.visibleCells[i] as! NewsCell).prepareToShow(from: self.newsItems[(self.tableView.indexPath(for: self.tableView.visibleCells[i])?.item)!]);
                self.tableView.visibleCells[i].layoutSubviews();
            }
            self.tableView.reloadData();
        }
    }
    
}

// Represents a news item, has a title and content as strings
struct NewsItem {
    var title : String;
    var content : String?;
    var media : WebImage?;
    var link : String?;
    
    static func loadNewsItems(onImageLoad: WebImageDelegate) -> [ NewsItem ] {
        var newses = [NewsItem]();

        let myURLString = AppDelegate.server + "/app/news";
        
        do {
            let url = NSURL(string: myURLString);
            let data = try String(contentsOf: url! as URL, encoding: String.Encoding.ascii);
            let rawNewsData = data.components(separatedBy: "\n###EON###\n");
            for rawData in rawNewsData {
                if(rawData != "" && rawData.components(separatedBy: "::").count >= 2){
                    var newsItem = NewsItem(title: "", content: "", media: nil, link: nil);
                    newsItem.title = rawData.components(separatedBy: "::")[0];
                    newsItem.content = rawData.components(separatedBy: "::")[2];
                    if(rawData.components(separatedBy: "::")[1] != ""){
                        newsItem.media = WebImage(fromURL: rawData.components(separatedBy: "::")[1], delegate: onImageLoad);
                    } else {
                        newsItem.media = nil;
                    }
                    
                    newsItem.link = nil;
                    if(newsItem.content?.contains("https") ?? false){
                        let words = newsItem.content?.components(separatedBy: .whitespacesAndNewlines);
                        for word in words!{
                            if(word.starts(with: "http")){
                                newsItem.link = word;
                            }
                        }
                        if(newsItem.link != nil && newsItem.link != ""){
                            newsItem.content = newsItem.content?.replacingOccurrences(of: newsItem.link!, with: "");
                        }
                        newsItem.content = newsItem.content?.trimmingCharacters(in: .whitespacesAndNewlines);
                    } else {
                        newsItem.link = nil;
                    }
                    
                    newses.append(newsItem);
                }
            }
        } catch {
            print("Error getting news");
            newses.append(NewsItem(title: "Error", content: "Could not load news right now. Please try again later.", media: nil, link: nil));
        }
        return newses;
    }
    
}

// Represents a cell for one peice of news
class NewsCell : UITableViewCell {
    
    var mediaView = CustomUIImageView();
    var title = UILabel();
    var content = UILabel();
    var link: String?;
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: .default, reuseIdentifier: "Identifier");
        reinit();
    }
    
    func reinit(){
        title.removeFromSuperview();
        content.removeFromSuperview();
        mediaView.removeFromSuperview();
        
        title = UILabel();
        content = UILabel();
        mediaView = CustomUIImageView();
        
        title.font = UIFont.boldSystemFont(ofSize: title.font.pointSize + 2);
        title.numberOfLines = 0;
        content.numberOfLines = 0;
        
        self.contentView.addSubview(title);
        self.contentView.addSubview(content);
        self.contentView.addSubview(mediaView);

        
   
        let onTap = UITapGestureRecognizer();
        onTap.addTarget(self, action: #selector(goToLink));
        self.addGestureRecognizer(onTap);
        
        mediaView.contentMode = .scaleAspectFit;
        mediaView.translatesAutoresizingMaskIntoConstraints = false;
        mediaView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, constant: -20).isActive = true;
        mediaView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: 0).isActive = true;
        mediaView.topAnchor.constraint(equalTo: content.bottomAnchor, constant: 10).isActive = true;
        mediaView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true;
        
        content.translatesAutoresizingMaskIntoConstraints = false;
        content.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10).isActive = true;
        content.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10).isActive = true;
        content.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5).isActive = true;
        
        title.translatesAutoresizingMaskIntoConstraints = false;
        title.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10).isActive = true;
        title.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10).isActive = true;
        title.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true;
        
        self.layoutSubviews();
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    @objc func goToLink(){
        if(self.link != nil && self.link != ""){
            let url = URL(string: self.link!);
            UIApplication.shared.open(url!, options: [:], completionHandler: nil);
        }
    }
    
    func prepareToShow(from: NewsItem){
        self.title.text =  from.title;
        self.content.text =  from.content;
        self.link = from.link;
        
        if(from.media != nil){
            mediaView.image = from.media?.image;
            layoutSubviews();
        } else {
            mediaView.image = nil;
        }
        if(from.link != nil && from.link != ""){
            self.accessoryType = .disclosureIndicator;
        } else {
            self.accessoryType = .none;
        }
    }
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
