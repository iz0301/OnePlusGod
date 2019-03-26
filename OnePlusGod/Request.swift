//
//  Request.swift
//  OnePlusGod
//
//  Created by Isaac Zachmann on 4/8/18.
//  Copyright © 2018 Isaac Zachmann. All rights reserved.
//

class Request : OptionList {

    override func viewDidLoad() {
        super.viewDidLoad();
        self.title = "Request";
        options.append(OptionListItem(image: #imageLiteral(resourceName: "trips"), title: "Request a trip", toController: RequestTrip()));
        options.append(OptionListItem(image: #imageLiteral(resourceName: "map"), title: "Request an event", toController: RequestEvent()));
        options.append(OptionListItem(image: #imageLiteral(resourceName: "teach"), title: "Request a teaching seminar", toController: RequestTeaching()));
        options.append(OptionListItem(image: #imageLiteral(resourceName: "map"), title: "Request a missionary/speaker", toController: RequestMissonary()));
    }
}
