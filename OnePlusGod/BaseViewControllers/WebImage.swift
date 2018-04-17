//
//  WebImage.swift
//  OnePlusGod
//
//  Created by Isaac Zachmann on 4/11/18.
//  Copyright © 2018 Isaac Zachmann. All rights reserved.
//

import UIKit

protocol WebImageDelegate {
    func didFinishLoadingImages();
}

/**
 A class for getting an image from the web
 */
class WebImage {
    
    private static var allImages = NSCache<NSString, UIImage>();
    var image : UIImage?;
    var delegate : WebImageDelegate;
    
    /**
     Loads the image from the url and calls the afterLoad selector once the image is loaded or fails to load
    */
    init(fromURL: String, delegate: WebImageDelegate) {
        self.delegate = delegate;
        if(WebImage.allImages.object(forKey: fromURL as NSString) != nil){
            self.image = WebImage.allImages.object(forKey: fromURL as NSString);
            return;
        }
        image = #imageLiteral(resourceName: "Loading");
         DispatchQueue.global(qos: .background).async {
            do {
                let imageData:NSData = try NSData(contentsOf: URL(string: fromURL)!);
                self.image = UIImage(data: imageData as Data);
                WebImage.allImages.setObject(self.image!, forKey: fromURL as NSString);
                self.delegate.didFinishLoadingImages();
            } catch {
                self.image = #imageLiteral(resourceName: "Fail");
                self.delegate.didFinishLoadingImages();
            }
        };
    }
    
}
