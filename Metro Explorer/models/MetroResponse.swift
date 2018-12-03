//
//  MetroResponse.swift
//  Metro Explorer
//
//  Created by zhenghao zhang on 12/2/18.
//  Copyright © 2018 zhenghao zhang. All rights reserved.
//

import Foundation

struct MetroResponse: Codable {
    
    let Stations: [Stations]
    
}

struct Stations: Codable {
    
    let Code: String
    let Name: String
    let StationTogether1: String
    let StationTogether2: String
    let LineCode1: String
    let LineCode2: String?
    let LineCode3: String?
    let LineCode4: String?

    let Lat: Double
    let Lon: Double
    let Address: Address
    
}

struct Address: Codable {
    
    let Street: String
    let City: String
    let State: String
    let Zip: String
    
}

