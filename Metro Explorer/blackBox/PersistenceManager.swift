//
//  PersistenceManager.swift
//  Metro Explorer
//
//  Created by zhenghao zhang on 11/26/18.
//  Copyright © 2018 zhenghao zhang. All rights reserved.
//

import Foundation

class PersistenceManager {
    static let sharedInstance = PersistenceManager()
    
    let landmarkKey = "landmarks"
    
    func saveLandmark(landmark: Landmark) {
        let userDefaults = UserDefaults.standard
        
        var landmarks = fetchLandmarks()
        landmarks.append(landmark)
        
        let encoder = JSONEncoder()
        let encodedWorkouts = try? encoder.encode(landmarks)
        
        userDefaults.set(encodedWorkouts, forKey: landmarksKey)
    }
    
    func fetchLandmarks() -> [Landmark] {
        let userDefaults = UserDefaults.standard
        
        if let landmarkData = userDefaults.data(forKey: landmarksKey), let workouts = try? JSONDecoder().decode([Workout].self, from: workoutData) {
            //workoutData is non-nil and successfully decoded
            return workouts
        }
        else {
            return [Landmark]()
        }
    }
    
    func fetchPushupRecord() -> Int {
        let workouts = fetchLandmarks()()
        
        return workouts.sorted(by: {$0.pushupsCompleted > $1.pushupsCompleted}).first?.pushupsCompleted ?? 0
    }
}

