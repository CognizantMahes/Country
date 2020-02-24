//
//  Country.swift
//  CountryDetails
//
//  Created by C, Maheswaran (Cognizant) on 23/02/20.
//  Copyright © 2020 C, Maheswaran (Cognizant). All rights reserved.
//

import Foundation

// MARK: - Country
class Country: Codable {
    let title: String?
    let rows: [Row]?

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case rows = "rows"
    }

    init(title: String?, rows: [Row]?) {
        self.title = title
        self.rows = rows
    }
    
}





// MARK: - Row
class Row: Codable {
    let title: String?
    let rowDescription: String?
    let imageHref: String?

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case rowDescription = "description"
        case imageHref = "imageHref"
    }

    init(title: String?, rowDescription: String?, imageHref: String?) {
        self.title = title
        self.rowDescription = rowDescription
        self.imageHref = imageHref
    }
   
}




