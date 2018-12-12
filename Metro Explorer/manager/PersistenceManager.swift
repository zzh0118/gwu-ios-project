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
    
    func checkStatus(landmark: Landmark) -> Bool{
        let userDefaults = UserDefaults.standard
        
        if let landmarkData = userDefaults.data(forKey: landmarksKey){
            
            return true
        }
        else {
            return false
        }
    }
    
    
   /* func fetchlandmarksRecord() -> Int {
        let landmarks = fetchLandmarks()
        return landmarks
//        return workouts.sorted(by: {$0.pushupsCompleted > $1.pushupsCompleted}).first?.pushupsCompleted ?? 0
    }*/
}
