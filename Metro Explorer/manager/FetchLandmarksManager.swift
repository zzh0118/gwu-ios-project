//
//  FetchLandmarktationsManager.swift
//  Landmark Explorer
//
//  Created by zhenghao zhang on 12/2/18.
//  Copyright © 2018 zhenghao zhang. All rights reserved.
//

import Foundation

protocol FetchLandmarksDelegate {
    func landmarksFound(_ landmark: [Landmark])
    func landmarksNotFound()
}
class FetchLandmarksManager {
    
    var delegate: FetchLandmarksDelegate?
    
    func fetchLandmark() {
        var urlComponents = URLComponents(string: "https://api.wmata.com/Rail.svc/json/jStations?")!
        
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
                
                self.delegate?.landmarksNotFound()
                
                return
            }
            
            //HERE - response is NOT nil and IS 200
            
            guard let data = data else {
                print("data is nil")
                
                self.delegate?.landmarksNotFound()
                
                return
            }
            
            //HERE - data is NOT nil
            
            let decoder = JSONDecoder()
            
            do {
                print("start do")
                let landmarkResponse = try decoder.decode(LandmarkResponse.self, from: data)
                
                //HERE - decoding was successful
                
                var landmarks = [Landmark]()
                
                for business in landmarkResponse.businesses {
                    //                    let address = venue.location.formattedAddress.joined(separator: " ")
                    //
                    //                    let iconPrefix = venue.categories.first?.icon.prefix
                    //                    let iconSuffix = venue.categories.first?.icon.suffix
                    
                    //                    var iconUrl: String? = nil
                    //
                    //                    if let iconPrefix = iconPrefix, let iconSuffix = iconSuffix {
                    //                        iconUrl = "\(iconPrefix)44\(iconSuffix)"
                    //                    }
                    
                    let landmark = Landmark(name: business.name,address: business.location.address1)
                    
                    landmarks.append(landmark)              }
                
                
                //now what do we do with the gyms????
                print(landmarks)
                
                self.delegate?.landmarksFound(landmarks)
                
                
            } catch let error {
                //if we get here, need to set a breakpoint and inspect the error to see where there is a mismatch between JSON and our Codable model structs
                print("codable failed - bad data format")
                print(error.localizedDescription)
                
                self.delegate?.landmarksNotFound()
            }
        }
        
        print("execute request")
        task.resume()
    }
}
