//
//  DetailsModel.swift
//  CountryDetails
//
//  Created by C, Maheswaran (Cognizant) on 24/02/20.
//  Copyright © 2020 C, Maheswaran (Cognizant). All rights reserved.
//

import Foundation
import UIKit
struct TopicsViewModel {
    var navigationTitle: String
    var topicsArray: [Topics]
    init(navigationTitle: String? , topicsArray:[Topics]?) {
        self.navigationTitle = navigationTitle!
        self.topicsArray = topicsArray!
    }
    init() {
        self.init(navigationTitle:"", topicsArray:[])
    // Convenience init call the designated init method
    }
}
struct Topics {
    var title: String
    var subTitle: String
    var imageHrefString: String
    var image: UIImage?
}


protocol DetailsViewModelDelegate {
    func updateUI()
}


class DetailsViewModel{
    private var currentUrl: String? //Get a hold of the latest request url
    var imageCache = NSCache<NSString, UIImage>()
    
    var delegate: DetailsViewModelDelegate?
    
    var detailsViewModel: TopicsViewModel? {
        didSet{
            DispatchQueue.main.async{
            print("Update")
                self.delegate?.updateUI()
            }
        }
    }
    
    let networkMgr = NetworkManager()
    
    func fetchImage(url: String, completionHandler: @escaping (UIImage?, Error?) -> Void){
        //networkMgr.fetchImage
        currentUrl = url
        
        if(imageCache.object(forKey: url as NSString) != nil){
            let image = imageCache.object(forKey: url as NSString)
            completionHandler(image , nil)
        }else{
        networkMgr.downloadImage(url: url, completion: { (data, error) -> Void in
           if let error = error {
                    completionHandler(nil, error)
                    return
                }
                guard let data = data, error == nil else {
                    return
                }
            if let downloadedImage = UIImage(data: data) {
                self.imageCache.setObject(downloadedImage, forKey: url as NSString)
                completionHandler(downloadedImage, error)
            }
            })
        }
    }
    
    func fetchDetailsList()  {
        networkMgr.fetchCountryDetails(completion: { (country, error) in
            if error != nil {
            }
            var topicsArray = [Topics]()
            if let rows = country?.rows {
                for row in rows{
                    let topics = Topics(title: row.title ?? "", subTitle: row.rowDescription ?? "", imageHrefString: row.imageHref ?? "")
                    topicsArray.append(topics)
                }
            }
            let titleStr = country?.title
            self.detailsViewModel = TopicsViewModel(navigationTitle: titleStr, topicsArray: topicsArray)
        })
    }
    var refreshTableView: (() -> ())?

   
}

