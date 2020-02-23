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
        detailsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "DetailsTableViewCell")
       
        //Set the navigation title
        navigationItem.title = "Canada"
    }


}
extension CountryDetailsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsTableViewCell", for: indexPath)

        cell.textLabel?.text = "Success"

                return cell
    }
    
    
}

