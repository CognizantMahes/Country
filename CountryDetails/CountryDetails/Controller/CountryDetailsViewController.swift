//
//  ViewController.swift
//  CountryDetails
//
//  Created by C, Maheswaran (Cognizant) on 22/02/20.
//  Copyright © 2020 C, Maheswaran (Cognizant). All rights reserved.
//

import UIKit

class CountryDetailsViewController: UIViewController {

    let detailsTableView = UITableView() // view
    let detailsModel = DetailsViewModel()
    var refreshControl = UIRefreshControl()
    var tableArray: [Topics] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //add tableview
        view.addSubview(detailsTableView)
        
        //auto layout constraint for table view
        detailsTableView.translatesAutoresizingMaskIntoConstraints = false
        detailsTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        detailsTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        detailsTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        detailsTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        //data sorce table view
        detailsTableView.dataSource = self
        // detailsTableView.delegate = self
        
        //register cell
        detailsTableView.register(DetailsTableViewCell.self, forCellReuseIdentifier: "DetailsTableViewCell")
       
        //Set the navigation title
        navigationItem.title = ""
        
        fetchDetailsAndRefreshUI()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        detailsTableView.addSubview(refreshControl)

        
    }

    @objc func refresh(sender:AnyObject) {
       // Code to refresh table view
        self.detailsTableView.reloadData()
        refreshControl.removeFromSuperview()
    
    }
    func fetchDetailsAndRefreshUI(){
        detailsModel.fetchDetailsList()
        detailsModel.refreshTableView = {
            DispatchQueue.main.async{
                self.tableArray = self.detailsModel.detailsViewModel!.topicsArray
                self.detailsTableView.reloadData()
                self.navigationItem.title = ""
                print("RELOAD table view")
            }
        }
    }

}
extension CountryDetailsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsTableViewCell", for: indexPath) as! DetailsTableViewCell
        cell.topics = self.tableArray[indexPath.row]
        //cell.iconImageView.image = DetailsViewModel.fetchImage()
            //tableArray[indexPath.row].imageHrefString
                return cell
    }
    
    
}

