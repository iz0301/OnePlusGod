//
//  RequestTeaching.swift
//  OnePlusGod
//
//  Created by Isaac Zachmann on 4/15/18.
//  Copyright © 2018 Isaac Zachmann. All rights reserved.
//

import UIKit

class RequestTeaching : FormViewController {
    
    static let themes = ["Any","Missions in general","The Bible and missions","Mission trips","Full time missions ministry","Other"];
    
    override func viewDidLoad() {
        super.viewDidLoad();
        title = "Request a Teaching";
        setNumberOfSections(number: 5);
        setNumberOfItems(number: 3, inSection: 0);
        setNumberOfItems(number: 6, inSection: 1);
        setNumberOfItems(number: 2, inSection: 2);
        setNumberOfItems(number: 3, inSection: 3);
        setNumberOfItems(number: 5, inSection: 4);
        setNumberOfItems(number: 3, inSection: 5);
        setSectionTitle(title: "Name", forSection: 0);
        setSectionTitle(title: "Address", forSection: 1);
        setSectionTitle(title: "Contact", forSection: 2);
        setSectionTitle(title: "Group Info", forSection: 3);
        setSectionTitle(title: "Place and Time", forSection: 4);
        setSectionTitle(title: "Teaching info", forSection: 5);
        
        setItemAtIndexPath(item: FormViewItem(title: "First", options: [], keyboardType: .default, autocorrectionType: .no, autocapitalizationType: .words, usePicker: false, value: ""), indexPath: IndexPath(item: 0, section: 0));
        setItemAtIndexPath(item: FormViewItem(title: "Last", options: [], keyboardType: .default, autocorrectionType: .no, autocapitalizationType: .words, usePicker: false, value: ""), indexPath: IndexPath(item: 1, section: 0));
        setItemAtIndexPath(item: FormViewItem(title: "Title (optional)", options: ["Mr.","Mrs.","Ms.","Pastor","Dr.","Other"], keyboardType: .default, autocorrectionType: .no, autocapitalizationType: .words, usePicker: true, value: ""), indexPath: IndexPath(item: 2, section: 0));
        
        setItemAtIndexPath(item: FormViewItem(title: "Address 1", options: [], keyboardType: .default, autocorrectionType: .no, autocapitalizationType: .words, usePicker: false, value: ""), indexPath: IndexPath(item: 0, section: 1));
        setItemAtIndexPath(item: FormViewItem(title: "Address 2 (optional)", options: [], keyboardType: .default, autocorrectionType: .no, autocapitalizationType: .words, usePicker: false, value: ""), indexPath: IndexPath(item: 1, section: 1));
        setItemAtIndexPath(item: FormViewItem(title: "City", options: [], keyboardType: .default, autocorrectionType: .no, autocapitalizationType: .words, usePicker: false, value: ""), indexPath: IndexPath(item: 2, section: 1));
        setItemAtIndexPath(item: FormViewItem(title: "State", options: [], keyboardType: .default, autocorrectionType: .no, autocapitalizationType: .words, usePicker: false, value: ""), indexPath: IndexPath(item: 3, section: 1));
        setItemAtIndexPath(item: FormViewItem(title: "Zip", options: [], keyboardType: .numberPad, autocorrectionType: .no, autocapitalizationType: .words, usePicker: false, value: ""), indexPath: IndexPath(item: 4, section: 1));
        setItemAtIndexPath(item: FormViewItem(title: "Country", options: [], keyboardType: .default, autocorrectionType: .no, autocapitalizationType: .words, usePicker: false, value: ""), indexPath: IndexPath(item: 5, section: 1));
        
        setItemAtIndexPath(item: FormViewItem(title: "Phone", options: [], keyboardType: .phonePad, autocorrectionType: .no, autocapitalizationType: .words, usePicker: false, value: ""), indexPath: IndexPath(item: 0, section: 2));
        setItemAtIndexPath(item: FormViewItem(title: "Email", options: [], keyboardType: .emailAddress, autocorrectionType: .no, autocapitalizationType: .none, usePicker: false, value: ""), indexPath: IndexPath(item: 1, section: 2));
        
        setItemAtIndexPath(item: FormViewItem(title: "Group Type", options: RequestTrip.iRepresentList, keyboardType: .default, autocorrectionType: .no, autocapitalizationType: .none, usePicker: true, value: ""), indexPath: IndexPath(item: 0, section: 3));
        setItemAtIndexPath(item: FormViewItem(title: "Your Role", options: RequestTrip.roleList, keyboardType: .default, autocorrectionType: .default, autocapitalizationType: .none, usePicker: true, value: ""), indexPath: IndexPath(item: 1, section: 3));
        setItemAtIndexPath(item: FormViewItem(title: "Group Size", options: ["1-10", "11-20", "21-30", "31-40", "41-50", "51-75","76-100","100+"], keyboardType: .default, autocorrectionType: .no, autocapitalizationType: .none, usePicker: true, value: ""), indexPath: IndexPath(item: 2, section: 3));
        
        setItemAtIndexPath(item: FormViewItem(title: "City", options: [], keyboardType: .default, autocorrectionType: .no, autocapitalizationType: .words, usePicker: false, value: ""), indexPath: IndexPath(item: 0, section: 4));
        setItemAtIndexPath(item: FormViewItem(title: "State", options: RequestTrip.listOfStates, keyboardType: .default, autocorrectionType: .no, autocapitalizationType: .none, usePicker: true, value: ""), indexPath: IndexPath(item: 1, section: 4));
        setItemAtIndexPath(item: FormViewItem(title: "Month", options: Calendar.current.monthSymbols, keyboardType: .default, autocorrectionType: .default, autocapitalizationType: .none, usePicker: true, value: ""), indexPath: IndexPath(item: 2, section: 4));
        setItemAtIndexPath(item: FormViewItem(title: "Year", options: ["2018", "2019", "2020", "2021", "2022"], keyboardType: .default, autocorrectionType: .default, autocapitalizationType: .none, usePicker: true, value: ""), indexPath: IndexPath(item: 3, section: 4));
        setItemAtIndexPath(item: FormViewItem(title: "Time", options: ["Morning","Afternoon","Evening"], keyboardType: .default, autocorrectionType: .default, autocapitalizationType: .none, usePicker: true, value: ""), indexPath: IndexPath(item: 4, section: 4));
        
        setItemAtIndexPath(item: FormViewItem(title: "Theme", options: RequestTeaching.themes, keyboardType: .default, autocorrectionType: .default, autocapitalizationType: .none, usePicker: true, value: ""), indexPath: IndexPath(item: 0, section: 5));
        setItemAtIndexPath(item: FormViewItem(title: "Type and purpose", options: [], keyboardType: .default, autocorrectionType: .default, autocapitalizationType: .sentences, usePicker: false, value: ""), indexPath: IndexPath(item: 1, section: 5));
        setItemAtIndexPath(item: FormViewItem(title: "Additional Information (Optional)", options: [], keyboardType: .default, autocorrectionType: .default, autocapitalizationType: .none, usePicker: false, value: ""), indexPath: IndexPath(item: 2, section: 5));
        
        let nextButton = UIButton(type: .system);
        nextButton.setTitle("Next", for: .normal);
        nextButton.tintColor = .white;
        nextButton.setTitleColor(nextButton.tintColor, for: .normal);
        nextButton.addTarget(self, action: #selector(reviewAndSubmit), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: nextButton);
    }
    
    /**
     TODO?: change so it doesnt have to create new view every time? Also rotation better
     */
    @objc func reviewAndSubmit(){
        updateValues();
        for sectionNum in 0...(getNumberOfSections() - 1){
            for itemNum in 0...(getNumberOfItems(inSection: sectionNum) - 1) {
                let item = getItem(at: IndexPath(item: itemNum, section: sectionNum));
                if(item.value == "" && !(item.title == "Address 2 (optional)" || item.title == "Additional Information (Optional)" || item.title == "Title (optional)")){
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
