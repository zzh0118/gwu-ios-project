//
//  Landmark.swift
//  Metro Explorer
//
//  Created by zhenghao zhang on 11/26/18.
//  Copyright © 2018 zhenghao zhang. All rights reserved.
//

import Foundation

class Landmark: Codable {
    let name: String
    let date: Date
    let pushupsCompleted:Int
    
    init(name: String, date: Date, pushupsCompleted: Int) {
        self.name = name
        self.date = date
        self.pushupsCompleted = pushupsCompleted
    }
}
