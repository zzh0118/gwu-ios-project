//
//  MetroStationsViewController.swift
//  Metro Explorer
//
//  Created by zhenghao zhang on 12/2/18.
//  Copyright © 2018 zhenghao zhang. All rights reserved.
//

import UIKit
import MBProgressHUD

class LandmarksViewController: UITableViewController {
    let fetchLandmarksManager = FetchLandmarksManager()
    var landmarks = [Landmark]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchLandmarks()

        
   //     fetchLandmarksManager.delegate = self
//        MBProgressHUD.hide(for: self.view, animated: true)
//        fetchLandmarksManager.fetchLandmark(latitude:40.7484 , longitude: 73.9857)


//        MBProgressHUD.hide(for: self.view, animated: true)
        //        let fetchLandmarksManager = FetchLandmarksManager()
        //        fetchLandmarksManager.delegate = self
        //        fetchLandmarksManager.fetchLandmark()
        
        
    }
    
    // MARK: - Table view data source
    private func fetchLandmarks(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        fetchLandmarksManager.delegate = self
        
//        fetchLandmarksManager.fetchLandmark(latitude:37.786882 , longitude: -122.399972)
        fetchLandmarksManager.fetchLandmark(latitude:38.900140 , longitude: -77.049447)
        print("what's the xx")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return landmarks.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "landmarkCell", for: indexPath) as! LandmarkTableViewCell
        
        let landmark = landmarks[indexPath.row]

        cell.landmarkNameLabel.text = landmark.name
        cell.landmarkAddressLabel.text = landmark.address
        cell.landmarkLogoImage.load(url: landmark.logoUrlString)
        //TODO: set the image
        
        return cell
    }
}

extension LandmarksViewController: FetchLandmarksDelegate {

    
    func landmarksFound(_ landmarks: [Landmark]) {
        print("landmarks found - here they are in the controller!")
        DispatchQueue.main.async {
            self.landmarks = landmarks
            
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    func landmarksNotFound(reason: FetchLandmarksManager.FailureReason) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
            
            let alertController = UIAlertController(title: "Problem fetching landmarks", message: reason.rawValue, preferredStyle: .alert)
            
            switch(reason) {
            case .noResponse:
                let retryAction = UIAlertAction(title: "Retry", style: .default, handler: { (action) in
                    self.fetchLandmarks()
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
