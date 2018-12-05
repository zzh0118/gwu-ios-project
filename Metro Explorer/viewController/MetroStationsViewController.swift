//
//  MetroStationsViewController.swift
//  Metro Explorer
//
//  Created by zhenghao zhang on 12/2/18.
//  Copyright © 2018 zhenghao zhang. All rights reserved.
//

import UIKit

class MetroStationsViewController: UITableViewController {

    var metros = [Metro]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchMetroStationsManager = FetchMetroStationsManager()
        fetchMetroStationsManager.delegate = self
        fetchMetroStationsManager.fetchMetros()
        
//        let fetchLandmarksManager = FetchLandmarksManager()
//        fetchLandmarksManager.delegate = self
//        fetchLandmarksManager.fetchLandmark()
        
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return metros.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "metroCell", for: indexPath) as! MetroTableViewCell
        
        let metro = metros[indexPath.row]
        
        cell.metroNameLabel.text = metro.name
        cell.metroAddressLabel.text = metro.address
        //TODO: set the image
        
        return cell
    }
}

extension MetroStationsViewController: FetchMetrosDelegate {
    func metrosFound(_ metros: [Metro]) {
        print("metros found")
        self.metros = metros
    }
    
    func metrosNotFound() {
        print("no metros found")
    }

}
