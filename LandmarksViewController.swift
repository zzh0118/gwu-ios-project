//
//  MetroStationsViewController.swift
//  Metro Explorer
//
//  Created by zhenghao zhang on 12/2/18.
//  Copyright © 2018 zhenghao zhang. All rights reserved.
//

import UIKit

class LandmarksViewController: UITableViewController {
    
    var landmarks = [Landmark]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchLandmarksManager = FetchLandmarksManager()
        fetchLandmarksManager.delegate = self
        fetchLandmarksManager.fetchLandmark()
        
        //        let fetchLandmarksManager = FetchLandmarksManager()
        //        fetchLandmarksManager.delegate = self
        //        fetchLandmarksManager.fetchLandmark()
        
        
    }
    
    // MARK: - Table view data source
    
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
        //TODO: set the image
        
        return cell
    }
}

extension LandmarksViewController: FetchLandmarksDelegate {


    
    func landmarksFound(_ landmarks: [Landmark]) {
        print("landmarks found")
        self.landmarks = landmarks
    }
    
    func landmarksNotFound() {
        print("no landmarks found")
    }
    
}
