//
//  Landmark.swift
//  Metro Explorer
//
//  Created by zhenghao zhang on 11/26/18.
//  Copyright © 2018 zhenghao zhang. All rights reserved.
//

import Foundation
struct Landmark : Codable{
    let name: String
    let address: String
    let logoUrlString: URL
    let rating :Double
    
    let latitude: Double
    let longitude: Double
}
