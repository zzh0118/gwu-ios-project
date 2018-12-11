//
//  MetroStationsViewController.swift
//  Metro Explorer
//
//  Created by zhenghao zhang on 12/2/18.
//  Copyright © 2018 zhenghao zhang. All rights reserved.
//

import UIKit
import MBProgressHUD


class MetroStationsViewController: UITableViewController {
    let locationDetector = LocationDetector()
    let fetchMetroStationsManager = FetchMetroStationsManager()

    var searchType = "search"

    var metros = [Metro]() {
        didSet {
        
            if searchType == "nearest"{
                metros.sort(by: { $0.dis < $1.dis })
            }
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        locationDetector.delegate = self
        fetchMetros()
    }
    
    private func fetchMetros() {
        print("fetchMetros once")
       
        MBProgressHUD.showAdded(to: self.view, animated: true)
        fetchMetroStationsManager.delegate = self
        locationDetector.findLocation()
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

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you select: \(indexPath.row)")
        
        performSegue(withIdentifier: "landmarksSegue", sender: self)
        
    }
    
    
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "landmarksSegue" {
            let destination = segue.destination as! LandmarksViewController
            destination.station = metros[tableView.indexPathForSelectedRow!.row]
        }
    }
}


extension MetroStationsViewController: LocationDetectorDelegate {
    func locationDetected(latitude: Double, longitude: Double) {
        print("locationDetected work")
        fetchMetroStationsManager.fetchMetros(latitude: latitude, longitude: longitude)
    }
    
    func locationNotDetected() {
        print("no location found :(")
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
            
            //TODO: Show a AlertController with error
        }
    }
}

extension MetroStationsViewController: FetchMetrosDelegate {
    func metrosFound(_ metros: [Metro]) {
        print("metros found - here they are in the controller!")
        DispatchQueue.main.async {
            self.metros = metros
            
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    func metrosNotFound(reason: FetchMetroStationsManager.FailureReason) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
            
            let alertController = UIAlertController(title: "Problem fetching gyms", message: reason.rawValue, preferredStyle: .alert)
            
            switch(reason) {
            case .noResponse:
                let retryAction = UIAlertAction(title: "Retry", style: .default, handler: { (action) in
                   self.fetchMetros()
                })
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler:nil)
                
                alertController.addAction(cancelAction)
                alertController.addAction(retryAction)
                
            case .non200Response, .noData, .badData:
                let okayAction = UIAlertAction(title: "Okay", style: .default, handler:nil)
                
                alertController.addAction(okayAction)
            }
            
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
}
