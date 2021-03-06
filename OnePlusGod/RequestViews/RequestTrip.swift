//
//  RequestTrip.swift
//  OnePlusGod
//
//  Created by Isaac Zachmann on 4/7/18.
//  Copyright © 2018 Isaac Zachmann. All rights reserved.
//

import UIKit

class RequestTrip : FormViewController {
    
    static let listOfStates = ["Alaska",
                               "Alabama",
                               "Arkansas",
                               "American Samoa",
                               "Arizona",
                               "California",
                               "Colorado",
                               "Connecticut",
                               "District of Columbia",
                               "Delaware",
                               "Florida",
                               "Georgia",
                               "Guam",
                               "Hawaii",
                               "Iowa",
                               "Idaho",
                               "Illinois",
                               "Indiana",
                               "Kansas",
                               "Kentucky",
                               "Louisiana",
                               "Massachusetts",
                               "Maryland",
                               "Maine",
                               "Michigan",
                               "Minnesota",
                               "Missouri",
                               "Mississippi",
                               "Montana",
                               "North Carolina",
                               " North Dakota",
                               "Nebraska",
                               "New Hampshire",
                               "New Jersey",
                               "New Mexico",
                               "Nevada",
                               "New York",
                               "Ohio",
                               "Oklahoma",
                               "Oregon",
                               "Pennsylvania",
                               "Puerto Rico",
                               "Rhode Island",
                               "South Carolina",
                               "South Dakota",
                               "Tennessee",
                               "Texas",
                               "Utah",
                               "Virginia",
                               "Virgin Islands",
                               "Vermont",
                               "Washington",
                               "Wisconsin",
                               "West Virginia",
                               "Wyoming"];
    
    static let iRepresentList = ["Organization", "School", "Church", "College", "Group", "Private", "Other"];
    
    static let roleList = ["Teacher", "Pastor", "Campus Minister", "Committee Leader", "Group Leader", "Business Owner", "Parent", "Spouse", "Other"];
    
    static let travelCountries = ["Haiti", "Thailand", "Burkina Faso", "Jamaica", "Indonesia", "South Africa", "Mali"];
    
    static let leaderTypes = ["OPG Staff person leads completely", "Co-Lead", "Our leader will mostly lead"];
    
    override func viewDidLoad() {
        super.viewDidLoad();
        title = "Request a Trip";
        setNumberOfSections(number: 5);
        setNumberOfItems(number: 2, inSection: 0);
        setNumberOfItems(number: 6, inSection: 1);
        setNumberOfItems(number: 2, inSection: 2);
        setNumberOfItems(number: 4, inSection: 3);
        setNumberOfItems(number: 6, inSection: 4);
        setSectionTitle(title: "Name", forSection: 0);
        setSectionTitle(title: "Address", forSection: 1);
        setSectionTitle(title: "Contact", forSection: 2);
        setSectionTitle(title: "Group Info", forSection: 3);
        setSectionTitle(title: "Trip Info", forSection: 4);
        
        setItemAtIndexPath(item: FormViewItem(title: "First", options: [], keyboardType: .default, autocorrectionType: .no, autocapitalizationType: .words, usePicker: false, value: ""), indexPath: IndexPath(item: 0, section: 0));
        setItemAtIndexPath(item: FormViewItem(title: "Last", options: [], keyboardType: .default, autocorrectionType: .no, autocapitalizationType: .words, usePicker: false, value: ""), indexPath: IndexPath(item: 1, section: 0));
        
        setItemAtIndexPath(item: FormViewItem(title: "Address 1", options: [], keyboardType: .default, autocorrectionType: .no, autocapitalizationType: .words, usePicker: false, value: ""), indexPath: IndexPath(item: 0, section: 1));
        setItemAtIndexPath(item: FormViewItem(title: "Address 2 (optional)", options: [], keyboardType: .default, autocorrectionType: .no, autocapitalizationType: .words, usePicker: false, value: ""), indexPath: IndexPath(item: 1, section: 1));
        setItemAtIndexPath(item: FormViewItem(title: "City", options: [], keyboardType: .default, autocorrectionType: .no, autocapitalizationType: .words, usePicker: false, value: ""), indexPath: IndexPath(item: 2, section: 1));
        setItemAtIndexPath(item: FormViewItem(title: "State", options: [], keyboardType: .default, autocorrectionType: .no, autocapitalizationType: .words, usePicker: false, value: ""), indexPath: IndexPath(item: 3, section: 1));
        setItemAtIndexPath(item: FormViewItem(title: "Zip", options: [], keyboardType: .numberPad, autocorrectionType: .no, autocapitalizationType: .words, usePicker: false, value: ""), indexPath: IndexPath(item: 4, section: 1));
        setItemAtIndexPath(item: FormViewItem(title: "Country", options: [], keyboardType: .default, autocorrectionType: .no, autocapitalizationType: .words, usePicker: false, value: ""), indexPath: IndexPath(item: 5, section: 1));
        
        setItemAtIndexPath(item: FormViewItem(title: "Phone", options: [], keyboardType: .phonePad, autocorrectionType: .no, autocapitalizationType: .words, usePicker: false, value: ""), indexPath: IndexPath(item: 0, section: 2));
        setItemAtIndexPath(item: FormViewItem(title: "Email", options: [], keyboardType: .emailAddress, autocorrectionType: .no, autocapitalizationType: .none, usePicker: false, value: ""), indexPath: IndexPath(item: 1, section: 2));
        
        setItemAtIndexPath(item: FormViewItem(title: "Group State", options: RequestTrip.listOfStates, keyboardType: .default, autocorrectionType: .no, autocapitalizationType: .none, usePicker: true, value: ""), indexPath: IndexPath(item: 0, section: 3));
        setItemAtIndexPath(item: FormViewItem(title: "Group Type", options: RequestTrip.iRepresentList, keyboardType: .default, autocorrectionType: .no, autocapitalizationType: .none, usePicker: true, value: ""), indexPath: IndexPath(item: 1, section: 3));
        setItemAtIndexPath(item: FormViewItem(title: "Your Role", options: RequestTrip.roleList, keyboardType: .default, autocorrectionType: .default, autocapitalizationType: .none, usePicker: true, value: ""), indexPath: IndexPath(item: 2, section: 3));
        setItemAtIndexPath(item: FormViewItem(title: "Group Size", options: ["2-5", "5-10", "10-15", "15-20", "20-25", "25+"], keyboardType: .default, autocorrectionType: .no, autocapitalizationType: .none, usePicker: true, value: ""), indexPath: IndexPath(item: 3, section: 3));
        
        setItemAtIndexPath(item: FormViewItem(title: "Travel Country", options: RequestTrip.travelCountries, keyboardType: .default, autocorrectionType: .default, autocapitalizationType: .none, usePicker: true, value: ""), indexPath: IndexPath(item: 0, section: 4));
        setItemAtIndexPath(item: FormViewItem(title: "Travel Month", options: Calendar.current.monthSymbols, keyboardType: .default, autocorrectionType: .default, autocapitalizationType: .none, usePicker: true, value: ""), indexPath: IndexPath(item: 1, section: 4));
        setItemAtIndexPath(item: FormViewItem(title: "Travel Year", options: ["2018", "2019", "2020", "2021", "2022"], keyboardType: .default, autocorrectionType: .default, autocapitalizationType: .none, usePicker: true, value: ""), indexPath: IndexPath(item: 2, section: 4));
        setItemAtIndexPath(item: FormViewItem(title: "Number of days", options: ["5", "6", "7", "8", "9", "10", "11+"], keyboardType: .default, autocorrectionType: .default, autocapitalizationType: .none, usePicker: true, value: ""), indexPath: IndexPath(item: 3, section: 4));
        setItemAtIndexPath(item: FormViewItem(title: "Leadership Type", options: RequestTrip.leaderTypes, keyboardType: .default, autocorrectionType: .default, autocapitalizationType: .none, usePicker: true, value: ""), indexPath: IndexPath(item: 4, section: 4));
        setItemAtIndexPath(item: FormViewItem(title: "Additional Information (Optional)", options: [], keyboardType: .default, autocorrectionType: .default, autocapitalizationType: .none, usePicker: false, value: ""), indexPath: IndexPath(item: 5, section: 4));
        
        let nextButton = UIButton(type: .system);
        nextButton.setTitle("Next", for: .normal);
        nextButton.tintColor = .white;
        nextButton.setTitleColor(nextButton.tintColor, for: .normal);
        nextButton.addTarget(self, action: #selector(reviewAndSubmit), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: nextButton);
    }
    
    let infoPopoverNav = UINavigationController();
    let infoPopover = UIViewController();
    
    @objc func info(){
        infoPopoverNav.modalPresentationStyle = .popover;
        infoPopover.title = "Requesting a trip";
        infoPopover.view.backgroundColor = .white;
        infoPopover.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(hideInfo));
        
        let infoView = UIWebView();
        infoView.loadRequest(NSURLRequest(url: Bundle.main.url(forResource: "RequestInfo", withExtension: "html")!) as URLRequest);
        infoPopover.view = infoView;
        
        infoPopoverNav.addChild(infoPopover);
        infoPopoverNav.popoverPresentationController?.sourceView = self.navigationItem.leftBarButtonItem?.customView;
        present(infoPopoverNav, animated: true, completion: nil);
    }
    
    /**
     TODO?: change so it doesnt have to create new view every time? Also rotation better
     */
    @objc func reviewAndSubmit(){
        updateValues();
        for sectionNum in 0...(getNumberOfSections() - 1){
            for itemNum in 0...(getNumberOfItems(inSection: sectionNum) - 1) {
                let item = getItem(at: IndexPath(item: itemNum, section: sectionNum));
                if(item.value == "" && !(item.title == "Address 2 (optional)" || item.title == "Additional Information (Optional)")){
                    let alert = UIAlertController(title: "Missing field(s)", message: "Please enter " + item.title, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil));
                    self.present(alert, animated: true, completion: nil)
                    return;
                }
            }
        }
        let review = UIViewController();
        review.view = UIScrollView();
        review.view.backgroundColor = .white;
        var lastLabel = review.view;
        for sectionNum in 0...(getNumberOfSections() - 1){
            for itemNum in 0...(getNumberOfItems(inSection: sectionNum) - 1) {
                let item = getItem(at: IndexPath(item: itemNum, section: sectionNum));
                let label = UILabel();
                label.text = item.title + ": " + item.value;
                label.numberOfLines = 0;
                label.lineBreakMode = .byWordWrapping;
                
                label.translatesAutoresizingMaskIntoConstraints = false;
                
                //  2.
                review.view.addSubview(label);
                
                //  3.
                let attribute: NSLayoutConstraint.Attribute = lastLabel == review.view ? .top : .bottom
                
                //  4.
                let topEdgeConstraint = NSLayoutConstraint(item: label,
                                                           attribute: .top,
                                                           relatedBy: .equal,
                                                           toItem: lastLabel,
                                                           attribute: attribute,
                                                           multiplier: 1.0,
                                                           constant: 15.0)
                
                let leftSideConstraint = NSLayoutConstraint(item: label,
                                                           attribute: .left,
                                                           relatedBy: .equal,
                                                           toItem: review.view,
                                                           attribute: .left,
                                                           multiplier: 1.0,
                                                           constant: 15.0);
                
                let widthConstraint = NSLayoutConstraint(item: label,
                                                            attribute: .width,
                                                            relatedBy: .equal,
                                                            toItem: review.view,
                                                            attribute: .width,
                                                            multiplier: 1.0,
                                                            constant: -30.0);
                
                review.view.addConstraint(widthConstraint);
                review.view.addConstraint(topEdgeConstraint)
                review.view.addConstraint(leftSideConstraint)
                lastLabel = label;
            }
        }
        let bottomConstraint = NSLayoutConstraint(item: lastLabel!,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: review.view,
                                                  attribute: .bottom,
                                                  multiplier: 1.0,
                                                  constant: -15.0);
        review.view.addConstraint(bottomConstraint);
        review.view.autoresizesSubviews = true;
        review.view.frame.size.width = self.view.frame.size.width;
        (review.view as! UIScrollView).contentSize.width = self.view.frame.size.width;
        
        
        let submitButton = UIButton(type: .system);
        submitButton.setTitle("Submit", for: .normal);
        submitButton.tintColor = .white;
        submitButton.setTitleColor(submitButton.tintColor, for: .normal);
        submitButton.addTarget(self, action: #selector(submitForm), for: .touchUpInside);
        review.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: submitButton);
        
        self.navigationController?.pushViewController(review, animated: true);
    }
    
    @objc func submitForm(){
        emailResults(address: "");
    }
}
