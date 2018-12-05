//
//  FetchMetroStationsManager.swift
//  Metro Explorer
//
//  Created by zhenghao zhang on 12/2/18.
//  Copyright © 2018 zhenghao zhang. All rights reserved.
//

import Foundation

protocol FetchMetrosDelegate {
    func metrosFound(_ metros: [Metro])
    func metrosNotFound(reason: FetchMetroStationsManager.FailureReason)
}
class FetchMetroStationsManager {
    
    enum FailureReason: String {
        case noResponse = "No response received" //allow the user to try again
        case non200Response = "Bad response" //give up
        case noData = "No data recieved" //give up
        case badData = "Bad data" //give up
    }
    var delegate: FetchMetrosDelegate?


//    func fetchNearbyGyms(latitude: Double, longitude: Double)
    func fetchMetros(latitude: Double, longitude: Double) {
        var urlComponents = URLComponents(string: "https://api.wmata.com/Rail.svc/json/jStations?")!
        urlComponents.queryItems = [
            URLQueryItem(name: "latitude", value: String(latitude)),
            URLQueryItem(name: "longitude", value: String(longitude)),
//            URLQueryItem(name: "categories", value: "gyms")
        ]

        
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: "ef5ba3eac7d3430a980ebbf24bc829f0"),
        ]
        
        let url = urlComponents.url!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            //PUT CODE HERE TO RUN UPON COMPLETION
            print("request complete")
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("response is nil or not 200")
                
                self.delegate?.metrosNotFound(reason: .non200Response)
                
                return
            }
            
            //HERE - response is NOT nil and IS 200
            
            guard let data = data else {
                print("data is nil")
                
                self.delegate?.metrosNotFound(reason: .noData)
                
                return
            }
            
            //HERE - data is NOT nil
            
            let decoder = JSONDecoder()
            
            do {
                print("start do")
                let metroResponse = try decoder.decode(MetroResponse.self, from: data)
                
                //HERE - decoding was successful
                
                var metros = [Metro]()
                
                for station in metroResponse.Stations {
                    
                    let metro = Metro(name: station.Name, address: station.Address.Street, latitude: station.Lat, longitude: station.Lon)
                    
                    metros.append(metro)
                    
                }
                
                
                //now what do we do with the gyms????
                print(metros)
                
                self.delegate?.metrosFound(metros)
                
                
            } catch let error {
                //if we get here, need to set a breakpoint and inspect the error to see where there is a mismatch between JSON and our Codable model structs
                print("codable failed - bad data format")
                print(error.localizedDescription)
                
                self.delegate?.metrosNotFound(reason: .badData)
            }
        }
        
        print("execute request")
        task.resume()
    }
}
