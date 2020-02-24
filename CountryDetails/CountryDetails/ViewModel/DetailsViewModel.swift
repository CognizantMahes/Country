//
//  DetailsModel.swift
//  CountryDetails
//
//  Created by C, Maheswaran (Cognizant) on 24/02/20.
//  Copyright © 2020 C, Maheswaran (Cognizant). All rights reserved.
//

import Foundation

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
}
class DetailsViewModel{
    
    var detailsViewModel: TopicsViewModel? {
        didSet{
            print("Updagte")
            self.refreshTableView?()
        }
    }
    
    var navigationTitle: String?{
        didSet{
            print("Updagte UI")
        }
    }
    var rowsArray: [Row]?{
        didSet{
            print("Updagte")
            self.refreshTableView?()
        }
    }
    
    let networkMgr = NetworkManager()
    func imageDownloadedSuccess(){
        self.refreshTableView?()
    }
    func fetchImage(url: String, completionHandler: @escaping (Data?, Error?) -> Void){
        //networkMgr.fetchImage
        networkMgr.downloadImage(url: url, completion: { (data, error) -> Void in
           if let error = error {
                    completionHandler(nil, error)
                    return
                }
                guard let data = data, error == nil else {
                    return
                }
                
                    completionHandler(data, error)
                
            })
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
            self.detailsViewModel = TopicsViewModel(navigationTitle: "", topicsArray: topicsArray)
            //self.rowsArray = country?.rows

        })
    }
    var refreshTableView: (() -> ())?

    
}

