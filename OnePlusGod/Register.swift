//
//  Register.swift
//  OnePlusGod
//
//  Created by Isaac Zachmann on 3/20/18.
//  Copyright © 2018 Isaac Zachmann. All rights reserved.
//

import UIKit

class Register : OptionList {
    
    let tripRegisterController = TripRegister();
    let eventRegisterController = EventRegister();
    
    convenience init(){
        self.init(nibName: nil, bundle: nil);
        self.title = "Register";
        self.view.backgroundColor = .white;
        
        self.tripRegisterController.getFromServer();
        self.eventRegisterController.getFromServer();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        options.append(OptionListItem(image: #imageLiteral(resourceName: "trips"), title: "Register for a trip", toController: tripRegisterController));
        options.append(OptionListItem(image: #imageLiteral(resourceName: "map"), title: "Register for an event", toController: eventRegisterController));
    }
    
}

class EventRegister : OptionList, WebImageDelegate {
    
    var events : [OccuranceItem] = [];
    
    init(){
        super.init(nibName: nil, bundle: nil);
        self.title = "Events";
        self.refreshControl = UIRefreshControl();
        self.refreshControl?.addTarget(self, action: #selector(getFromServer), for: .valueChanged);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func getFromServer() {
        self.tableView.refreshControl?.beginRefreshing();
         DispatchQueue.global(qos: .background).async {
            self.events = OccuranceItem.loadOptions(fromURL: AppDelegate.server + "/app/events", webImagesDelegate: self);
            DispatchQueue.main.async {
                self.updateOptions();
                self.tableView.reloadData();
                self.refreshControl?.endRefreshing();
            }
        };
    }
    
    func didFinishLoadingImages() {
        DispatchQueue.main.async {
            self.updateOptions();
        }
    }
    
    func updateOptions(){
        if let occ = self.navigationController?.topViewController as? OccurrenceItemView {
            occ.updateImages();
        }
        options = [OptionListItem]();
        for event in events {
            options.append(OptionListItem(image: event.imageIcon?.image, title: event.title, toController: nil));
        }
        tableView.reloadData();
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(OccurrenceItemView(with: events[indexPath.item]), animated: true);
    }
}

class TripRegister : OptionList, WebImageDelegate {
    
    var trips : [OccuranceItem] = [];
    
    init(){
        super.init(nibName: nil, bundle: nil);
        self.title = "Trips";
        self.refreshControl = UIRefreshControl();
        self.refreshControl?.addTarget(self, action: #selector(getFromServer), for: .valueChanged);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func getFromServer() {
        self.tableView.refreshControl?.beginRefreshing();
        DispatchQueue.global(qos: .background).async {
            self.trips = OccuranceItem.loadOptions(fromURL: AppDelegate.server + "/app/trips", webImagesDelegate: self);
            DispatchQueue.main.async {
                self.updateOptions();
                self.tableView.reloadData();
                self.refreshControl?.endRefreshing();
            }
        }
    }
    
    func didFinishLoadingImages() {
        DispatchQueue.main.async {
            self.updateOptions();
        }
    }
    
    func updateOptions(){
        if let occ = self.navigationController?.topViewController as? OccurrenceItemView {
            occ.updateImages();
        }
        options = [OptionListItem]();
        for trip in trips {
            options.append(OptionListItem(image: trip.imageIcon?.image, title: trip.title, toController: nil));
        }
        tableView.reloadData();
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(OccurrenceItemView(with: trips[indexPath.item]), animated: true);
    }
}

struct OccuranceItem {
    /**
     The image to use as the icon for the occurance
    */
    var imageIcon : WebImage?;
    
    /**
     The url of the registration from, I think this is going to be a live link so it connects directly
     to webconnex
     */
    var title = "";
    
    /**
     The url of the registration from, I think this is going to be a live link so it connects directly
     to webconnex
     */
    var registerURL = "";
    
    /**
     The start date/time of this occurrence
     */
    var startDate : String = "";
    
    /**
     The end date/time of this occurrence
     */
    var endDate : String = "";
    
    /**
     The name of the location and/or the address of this occurrence
     */
    var locationName = "";
    
    /**
     A shrot summary about this occurrence in html format so that images/video are supported. Keep this short though
     */
    var info : String = "";
    
    /**
     A string that contains urls of different images/videos about the trip
     */
    var media = "";
    var mediaImages = [WebImage]();
    
    /**
     example from file on server:
     
     Title
     :EndOfTitle:
     http://thisistheimageurl.com/
     :EndOfImage:
     mm/dd/yyyy hh:mm:ss:::mm/dd/yyyy hh:mm:ss
     :EndOfDates:
     1234 Address road
     city
     state
     whatever you want
     :EndOfLocation:
     http://registerUrl.com/
     :EndOfRegister:
     http://urltoimage.com
     http://urlofanotherimage.com
     http://urltoVideoMaybe??.com
     :EndOfMedia:
     Info goes here
     ###EON###
     */
    static func loadOptions(fromURL: String, webImagesDelegate: WebImageDelegate) -> [OccuranceItem] {
        var occurrences = [OccuranceItem]();
        do {
            let url = NSURL(string: fromURL);
            let allRawData = try String(contentsOf: url! as URL, encoding: String.Encoding(rawValue: 1));
            let rawDatas = allRawData.components(separatedBy: "\n###EON###\n");
            for rawData in rawDatas {
                if(rawData == ""){
                    break;
                }
                let title = rawData.components(separatedBy: "\n:EndOfTitle:\n")[0];
                
                let afterTitle = rawData.components(separatedBy: "\n:EndOfTitle:\n")[1];
                let imageUrl = afterTitle.components(separatedBy: "\n:EndOfImage:\n")[0];
                
                var icon : WebImage? = nil;
                if (imageUrl != "") {
                    icon = WebImage(fromURL: imageUrl, delegate: webImagesDelegate);
                }
                
                let afterImage = afterTitle.components(separatedBy: "\n:EndOfImage:\n")[1];
                let datesString = afterImage.components(separatedBy: "\n:EndOfDates:\n")[0];
                let startDateRaw = datesString.components(separatedBy: ":::")[0];
                let endDateRaw = datesString.components(separatedBy: ":::")[1];
                
                let afterDates = afterImage.components(separatedBy: "\n:EndOfDates:\n")[1];
                let locationName = afterDates.components(separatedBy: "\n:EndOfLocation:\n")[0];
                
                let afterLocation = afterDates.components(separatedBy: "\n:EndOfLocation:\n")[1];
                let registerURL = afterLocation.components(separatedBy: "\n:EndOfRegister:\n")[0];
                
                let afterRegister = afterLocation.components(separatedBy: "\n:EndOfRegister:\n")[1];
                let media = afterRegister.components(separatedBy: "\n:EndOfMedia:\n")[0];
                
                let afterMedia = afterRegister.components(separatedBy: "\n:EndOfMedia:\n")[1];
                let info = afterMedia;
                
                var startDate = "";
                var endDate = "";
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss";
                dateFormatter.timeZone = TimeZone(abbreviation: "EDT");
                let startDateDate = dateFormatter.date(from: startDateRaw);
                let endDateDate = dateFormatter.date(from: endDateRaw);
                dateFormatter.dateFormat = "MMMM d, yyyy h:mm a";
                if(startDateDate != nil && endDateDate != nil){
                    startDate = "Starts " + dateFormatter.string(from: startDateDate!);
                    endDate = "Ends " + dateFormatter.string(from: endDateDate!);
                } else {
                    startDate = "";
                    endDate = "";
                }
                
                var mediaImages = [WebImage]();
                if(media != ""){
                    for i in 0...(media.components(separatedBy: "\n").count - 1) {
                        let mediaURL = media.components(separatedBy: "\n")[i];
                        mediaImages.append(WebImage(fromURL: mediaURL, delegate: webImagesDelegate));
                    }
                }
                
                occurrences.append(OccuranceItem(imageIcon: icon, title: title, registerURL: registerURL, startDate: startDate, endDate: endDate, locationName: locationName, info: info, media: media, mediaImages: mediaImages));
            }
        } catch {
            print("Error getting trips/events");
            occurrences.append(OccuranceItem(imageIcon: nil, title: "Error", registerURL: "", startDate: "", endDate: "", locationName: "", info: "There was an error loading info, make sure you are connected to internet and try again.", media: "", mediaImages: [WebImage]()));
        }
        return occurrences;
    }
}


/**
 A class to hold information about a trip or event. This information is retrieved from the server. The class can be presented as a view controller, and shown in and OptionsList by calling getOptionListItem
 */
class OccurrenceItemView : UITableViewController {
    
    var infoCell = UITableViewCell();
    var registerCell = UITableViewCell();
    var mediaCells = [UITableViewCell]();
    var startDateCell = UITableViewCell();
    var endDateCell = UITableViewCell();
    var locationCell = UITableViewCell();
    
    var occurrenceItem : OccuranceItem;
    
    init(with: OccuranceItem) {
        occurrenceItem = with;
        super.init(nibName: nil, bundle: nil);
        
        self.title = with.title;
        self.tableView.allowsSelection = false;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.separatorInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5);
        refreshCells();
    }
    
    func updateImages(){
        DispatchQueue.main.async {
            self.refreshCells();
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.title = occurrenceItem.title;
        refreshCells();
    }
    
    /*
     Updates the unreusable cells with new information matching the data variables (info,startDate,etc.)
     */
    func refreshCells(){
        infoCell.textLabel?.text = occurrenceItem.info;
        infoCell.textLabel?.numberOfLines = 0;
        infoCell.textLabel?.lineBreakMode = .byWordWrapping;
        
        registerCell.textLabel?.text = "Register now!";
        registerCell.accessoryType = .disclosureIndicator;
        
        let onTap = UITapGestureRecognizer();
        onTap.addTarget(self, action: #selector(register));
        registerCell.addGestureRecognizer(onTap);
        
        
        mediaCells = [UITableViewCell]();
        for mediaImage in occurrenceItem.mediaImages {
            let newCell = UITableViewCell();
            
            newCell.textLabel?.numberOfLines = 0;
                
            let imageView = CustomUIImageView();
            imageView.contentMode = .scaleAspectFit;
            imageView.image = mediaImage.image;
            
            newCell.contentView.addSubview(imageView);
            imageView.translatesAutoresizingMaskIntoConstraints = false;
            imageView.widthAnchor.constraint(equalTo: newCell.contentView.widthAnchor, constant: -20).isActive = true;
            imageView.heightAnchor.constraint(equalTo: newCell.contentView.heightAnchor, constant: -20).isActive = true;
            imageView.centerXAnchor.constraint(equalTo: newCell.contentView.centerXAnchor, constant: 0).isActive = true;
            imageView.centerYAnchor.constraint(equalTo: newCell.contentView.centerYAnchor, constant: 0).isActive = true;
            
            //To recalculate to fit image:
            newCell.setNeedsLayout();
            newCell.layoutIfNeeded();
            mediaCells.append(newCell);
        }
        
            
        startDateCell.textLabel?.numberOfLines = 0;
        endDateCell.textLabel?.numberOfLines = 0;
        startDateCell.textLabel?.text = occurrenceItem.startDate;
        endDateCell.textLabel?.text = occurrenceItem.endDate;
        
        locationCell.textLabel?.numberOfLines = 0;
        locationCell.textLabel?.lineBreakMode = .byWordWrapping;
        locationCell.textLabel?.text = occurrenceItem.locationName;
        
        self.tableView.reloadData();
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator);
        
        for i in 0...(mediaCells.count - 1) {
            mediaCells[i].contentView.setNeedsLayout();
            mediaCells[i].contentView.layoutIfNeeded();
        }
        tableView.reloadData();
    }
    
    @objc func register() {
        let registerViewController = CustomWebViewController();
        registerViewController.loadFromURL(url: occurrenceItem.registerURL);
        /*let registerView = CustomWebView();
        registerView.loadFromURL(url: occurrenceItem.registerURL);
        registerViewController.view = registerView;*/
        self.navigationController?.pushViewController(registerViewController, animated: true);
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var num = 0;
        if(occurrenceItem.info != ""){
            num += 1;
        }
        if(occurrenceItem.registerURL != ""){
            num += 1;
        }
        if(mediaCells.count > 0){
            num += mediaCells.count;
        }
        if(occurrenceItem.startDate != ""){
            num += 1;
        }
        if(occurrenceItem.endDate != ""){
            num += 1;
        }
        if(occurrenceItem.locationName != ""){
            num += 1;
        }
        return num;
    }
    
    /**
     Does not reuse cells because there are only a couple
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var num = 0;
        if(occurrenceItem.info != ""){
            if(num == indexPath.item){
                return infoCell;
            }
            num += 1;
        }
        if(occurrenceItem.registerURL != ""){
            if(num == indexPath.item){
                return registerCell;
            }
            num += 1;
        }
        if(mediaCells.count > 0){
            if(num <= indexPath.item && (num + mediaCells.count) > indexPath.item){
                return mediaCells[indexPath.item - num];
            }
            num += mediaCells.count;
        }
        if(occurrenceItem.startDate != ""){
            if(num == indexPath.item){
                return startDateCell;
            }
            num += 1;
        }
        if(occurrenceItem.endDate != ""){
            if(num == indexPath.item){
                return endDateCell;
            }
            num += 1;
        }
        if(occurrenceItem.locationName != ""){
            if(num == indexPath.item){
                return locationCell;
            }
            num += 1;
        }
        return UITableViewCell();
    }
}

/**
    A custom UIImageView that automaticially sets its intrinsicContentSize to fit the image well
 */
class CustomUIImageView : UIImageView {
    
    override var intrinsicContentSize: CGSize {
        if(image != nil){
            if(self.frame.size.height <= 0){
                self.frame.size = image!.size;
            }
            //Recalculates the frame.size before figuring.
            self.superview?.layoutSubviews();
            if((image?.size.width)! > self.frame.size.width){
                let scale = self.frame.size.width / (image?.size.width)!
                return CGSize(width: scale * (image?.size.width)!, height: scale * image!.size.height);
            } else {
                return image!.size;
            }
        }
        return CGSize(width: 100, height: 100);
    }
    
    //Implement later:
    /*override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if(action == #selector(UIResponderStandardEditActions.copy(_:))){
            return true;
        }
        return super.canPerformAction(action, withSender: sender);
    }*/

}
