//
//  DetailsTableViewCell.swift
//  CountryDetails
//
//  Created by C, Maheswaran (Cognizant) on 24/02/20.
//  Copyright © 2020 C, Maheswaran (Cognizant). All rights reserved.
//

import Foundation
import UIKit

protocol ImageDelegate {
func imageDownloaded()
}

class DetailsTableViewCell: UITableViewCell{
    
    var imageDelegate: ImageDelegate?

    var downloadManager = AsyncImageView()
    
    var topics: Topics?{
        didSet{
            guard let topicItem = topics else {return}
            titleLabel.text = topicItem.title
            descLabel.text = topicItem.subTitle
            
            
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.white
        //adding container view which holds all the elements
        self.contentView.addSubview(containerView)
        containerView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:5).isActive = true
        containerView.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant:5).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-5).isActive = true
        containerView.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor, constant:-5).isActive = true
        
        
        //ContainerView contains 3 elements, profile,title,desc
        containerView.addSubview(iconImageView)
        //image should display in center with respect to title,desc
        iconImageView.centerYAnchor.constraint(equalToSystemSpacingBelow: self.containerView.centerYAnchor, multiplier: 1).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo:containerView.leadingAnchor, constant:5).isActive = true
        //width,height should be constant otherwise collapse
        iconImageView.widthAnchor.constraint(equalToConstant:75).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant:75).isActive = true
        
        containerView.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo:self.iconImageView.trailingAnchor, constant:5).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        //height should be constant otherwise collapse
        titleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        titleLabel.topAnchor.constraint(equalTo:containerView.topAnchor,constant: 5).isActive = true
        
        containerView.addSubview(descLabel)
        descLabel.topAnchor.constraint(equalTo:self.titleLabel.bottomAnchor,constant:2).isActive = true
        descLabel.leadingAnchor.constraint(equalTo:titleLabel.leadingAnchor).isActive = true
        descLabel.trailingAnchor.constraint(equalTo:titleLabel.trailingAnchor).isActive = true
        descLabel.bottomAnchor.constraint(equalTo:containerView.bottomAnchor,constant: -2).isActive = true
        
        print(UIScreen.main.bounds.size.width)
        print(UIScreen.main.bounds.size.height)
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
    
    //title
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .black
        label.backgroundColor = UIColor.green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //desc
    let descLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Book", size: 16)
        label.textColor =  .white
        label.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let iconImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        //img.layer.cornerRadius = 38
        img.clipsToBounds = true
        return img
    }()
}
