//
//  DetailsTableViewCell.swift
//  CountryDetails
//
//  Created by C, Maheswaran (Cognizant) on 24/02/20.
//  Copyright © 2020 C, Maheswaran (Cognizant). All rights reserved.
//

import Foundation
import UIKit
class DetailsTableViewCell: UITableViewCell{
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.white
        //adding container view which holds all the elements
        self.contentView.addSubview(containerView)
        containerView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:5).isActive = true
        containerView.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant:5).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-5).isActive = true
        containerView.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor, constant:-5).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.blue
        view.clipsToBounds = true// this will make sure its children do not go out of the boundary
        return view
    }()
}
