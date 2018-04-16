//
//  News.swift
//  OnePlusGod
//
//  Created by Isaac Zachmann on 3/17/18.
//  Copyright © 2018 Isaac Zachmann. All rights reserved.
//
/*
import UIKit

class News : UITableViewController {
    
    @objc func toTheWebsite(){
        let alert = UIAlertController(title: "More", message: "For more information, please visit the website.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil));
        alert.addAction(UIAlertAction(title: "Go", style: .default, handler: {action in
            UIApplication.shared.open(URL(string: "https://oneplusgod.org")!, options: [:], completionHandler: nil);
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
        
        self.view.backgroundColor = UIColor.lightGray;
    }
    
    @objc func refreshNewsItems(){
         DispatchQueue.global(qos: .background).async {
            self.newsItems = NewsItem.loadNewsItems();
            DispatchQueue.main.async{
                self.tableView.reloadData();
                self.tableView.refreshControl?.endRefreshing();
            }
        };
    }
    
    override func viewDidLoad() {
        // Set up table:
        self.refreshControl = UIRefreshControl();
        self.refreshControl?.addTarget(self, action: #selector(refreshNewsItems), for: UIControlEvents.valueChanged);
        self.refreshControl?.beginRefreshing();
        
        self.refreshControl?.backgroundColor = UIColor.lightGray;
        
        self.tableView.register(NewsCell.self, forCellReuseIdentifier: "Identifier");
        
        self.tableView.allowsSelection = false;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        self.newsItems.append(NewsItem(title: "Loading...", content: ""));
        
        // load news:
        self.refreshNewsItems();
        //self.view.addSubview(feed);
    }

    // Function handels when the frame is resized (i.e. rotation):
    /*override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        .frame.size = size;
    }*/
    
    //Called when a row is selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*print("Num: \(indexPath.row)")
        print("Value: \(myArray[indexPath.row])")*/
        //let cell = tableView.cellForRow(at: indexPath);
    }
    
    // Should return the number of cells
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count;
    }
    
    // Called when the table needs a cell, probably nothing needs changed here. Change stuff in NewsCell classs
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Identifier", for: indexPath as IndexPath);
        cell.textLabel?.text = newsItems[indexPath.item].title;
        cell.detailTextLabel?.text = newsItems[indexPath.item].content;
        return cell;
    }
}

// Represents a news item, has a title and content as strings
struct NewsItem {
    var title : String;
    var content : String?;
    
    static func loadNewsItems() -> [ NewsItem ] {
        var newses = [NewsItem]();
        
        let myURLString = AppDelegate.server + "/app/news";
        
        do {
            let url = NSURL(string: myURLString);
            let data = try String(contentsOf: url! as URL, encoding: String.Encoding(rawValue: 1));
            let rawNewsData = data.components(separatedBy: "\n###EON###\n");
            for rawData in rawNewsData {
                if(rawData != "" && rawData.components(separatedBy: "::").count >= 2){
                    var newsItem = NewsItem(title: "", content: "");
                    newsItem.title = rawData.components(separatedBy: "::")[0];
                    newsItem.content = rawData.components(separatedBy: "::")[1];
                    newses.append(newsItem);
                }
            }
        } catch {
            print("Error getting news");
            newses.append(NewsItem(title: "Error", content: "Could not load news right now. Please try again later."));
        }
        
        return newses;
    }
    
}

// Represents a cell for one peice of news
class NewsCell : UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Identifier");
        self.detailTextLabel?.numberOfLines = 0;
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
}
*/
