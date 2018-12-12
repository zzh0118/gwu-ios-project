//
//  PersistenceManager.swift
//  Metro Explorer
//
//  Created by zhenghao zhang on 12/2/18.
//  Copyright © 2018 zhenghao zhang. All rights reserved.
//


import Foundation

class PersistenceManager {
    static let sharedInstance = PersistenceManager()
    
    let landmarksKey = "landmarks"
    
    func saveLandmark(landmark: Landmark) {
        let userDefaults = UserDefaults.standard
        
        var landmarks = fetchLandmarks()
        landmarks.append(landmark)
        
        let encoder = JSONEncoder()
        let encodedLandmarks = try? encoder.encode(landmarks)
        
        userDefaults.set(encodedLandmarks, forKey: landmarksKey)
    }
    
    func fetchLandmarks() -> [Landmark] {
        let userDefaults = UserDefaults.standard
        
        if let landmarkData = userDefaults.data(forKey: landmarksKey), let landmarks = try? JSONDecoder().decode([Landmark].self, from: landmarkData) {
            return landmarks
        }
        else {
            return [Landmark]()
        }
    }
    
    func checkStatus(landmarkCheck: Landmark) -> Bool{
        let userDefaults = UserDefaults.standard
        
        if let landmarkData = userDefaults.data(forKey: landmarksKey), let landmarks = try? JSONDecoder().decode([Landmark].self, from: landmarkData) {
            let status = landmarks.contains{ element in
                if element.name == landmarkCheck.name{
                    return true
                } else {
                    return false
                }
            }
            return status
        }
        else {
            return false
        }
        
    }
    
    func deleteLandmark(landmarkDelete: Landmark){
        let userDefaults = UserDefaults.standard
        
        var landmarks = fetchLandmarks()
        landmarks.removeAll(where:{$0.name == landmarkDelete.name} )
        let encoder = JSONEncoder()
        let encodedLandmarks = try? encoder.encode(landmarks)
        
        userDefaults.set(encodedLandmarks, forKey: landmarksKey)
        
        
    }

}
