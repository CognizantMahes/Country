//
//  DetailsModel.swift
//  CountryDetails
//
//  Created by C, Maheswaran (Cognizant) on 24/02/20.
//  Copyright © 2020 C, Maheswaran (Cognizant). All rights reserved.
//

import Foundation

class DetailsModel{

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
    func fetchDetailsList()  {
        networkMgr.fetchCountryDetails(completion: { (country, error) in
            if error != nil {
            }
            self.rowsArray = country?.rows

        })
    }
    var refreshTableView: (() -> ())?

    
}
