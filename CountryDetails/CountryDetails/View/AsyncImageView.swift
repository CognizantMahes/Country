//
//  AsyncImageView.swift
//  CountryDetails
//
//  Created by C, Maheswaran (Cognizant) on 24/02/20.
//  Copyright © 2020 C, Maheswaran (Cognizant). All rights reserved.
//

import Foundation
import UIKit


class AsyncImageView: UIImageView {
    
    private var currentUrl: String? //Get a hold of the latest request url
    var imageCache = NSCache<NSString, UIImage>()
    var detailsViewModel = DetailsViewModel()
    override var image: UIImage?{
        didSet{
            detailsViewModel.refreshTableView?()
        }
    }
        
    public func imageFromServerURL(url: String, completion: @escaping (Bool?) -> Void) {
        currentUrl = url
        
        if(imageCache.object(forKey: url as NSString) != nil){
            self.image = imageCache.object(forKey: url as NSString)
        }else{
            
            // fetch from Data Model
            
            detailsViewModel.fetchImage(url: url, completionHandler: { (data, error) -> Void in
                if error == nil {
//                    DispatchQueue.main.async{
//                        if let downloadedImage = UIImage(data: data!) {
//                            if (url == self.currentUrl) {//Only cache and set the image view when the downloaded image is the one from last request
//                                self.imageCache.setObject(downloadedImage, forKey: url as NSString)
//                                self.image = downloadedImage
//                                completion(true)
//                            }
//                            
//                        }
//                    }
                    
                    
                }
            })
            
            
        }
    }}
