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
                let url = URL(string: fromURL);
                if(url != nil){
                    let imageData:NSData = try NSData(contentsOf: url!);
                    self.image = UIImage(data: imageData as Data);
                    if(self.image != nil){
                        WebImage.allImages.setObject(self.image!, forKey: fromURL as NSString);
                    } else {
                        self.image = #imageLiteral(resourceName: "Fail");
                    }
                    self.delegate.didFinishLoadingImages();
                }
            } catch {
                self.image = #imageLiteral(resourceName: "Fail");
                self.delegate.didFinishLoadingImages();
            }
        };
    }
}


/**
 A custom UIImageView that automaticially sets its intrinsicContentSize to fit the image well
 */
class CustomUIImageView : UIImageView {
    
    /*init(){
        super.init(frame: .zero);
        self.isUserInteractionEnabled = true;
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTap));
        self.addGestureRecognizer(tap);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }*/
    
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
        return .zero;
    }
    
    //Implement later:
    /*override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
     if(action == #selector(UIResponderStandardEditActions.copy(_:))){
     return true;
     }
     return super.canPerformAction(action, withSender: sender);
     }*/
    
}
