//
//  FetchLandmarktationsManager.swift
//  Landmark Explorer
//
//  Created by zhenghao zhang on 12/2/18.
//  Copyright © 2018 zhenghao zhang. All rights reserved.
//

import Foundation

struct Constants {
    static let yelpAPIKey = "nYStQP0t3DJF42l6mbEfram_xMJXP2D4L_uixT0GG-O9s50v37-s5NXiy6FouQ-IU93OI6Env4I14qj2Dy2vp_2ewmUkNO1I0RluEMOXKlWTtTBZlb9_KCZtdvsGXHYx"
    static let yelpAPIBaseUrl = "https://api.yelp.com/v3/businesses/search"
}

protocol FetchLandmarksDelegate {
    func landmarksFound(_ landmark: [Landmark])
    func landmarksNotFound(reason: FetchLandmarksManager.FailureReason)
}
class FetchLandmarksManager {
    
    enum FailureReason: String {
        case noResponse = "No response received" //allow the user to try again
        case non200Response = "Bad response" //give up
        case noData = "No data recieved" //give up
        case badData = "Bad data" //give up
    }
    var delegate: FetchLandmarksDelegate?
    
    
    func fetchLandmark(latitude: Double, longitude: Double) {
        
        var urlComponents = URLComponents(string: Constants.yelpAPIBaseUrl)!
        
        urlComponents.queryItems = [
            URLQueryItem(name: "categories", value: "landmarks"),
            URLQueryItem(name: "latitude", value: String(latitude)),
            URLQueryItem(name: "longitude", value: String(longitude)),
            
        ]
       
        let url = urlComponents.url!
        var request = URLRequest(url: url)
        request.addValue("Bearer \(Constants.yelpAPIKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            //PUT CODE HERE TO RUN UPON COMPLETION
            print("request complete")
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("response is nil or not 200")
                
                self.delegate?.landmarksNotFound(reason: .non200Response)
                
                return
            }
            
            //HERE - response is NOT nil and IS 200
            
            guard let data = data else {
                print("data is nil")
                
                self.delegate?.landmarksNotFound( reason: .noData)
                
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
                    
                    let landmark = Landmark(name: business.name,address: business.location.address1,logoUrlString: business.imageUrl, rating: business.rating, latitude:business.coordinates.latitude, longitude: business.coordinates.longitude)
                    
                    landmarks.append(landmark)              }
                
                
                //now what do we do with the gyms????

                
                self.delegate?.landmarksFound(landmarks)
                
                
            } catch let error {
                //if we get here, need to set a breakpoint and inspect the error to see where there is a mismatch between JSON and our Codable model structs
                print("codable failed - bad data format")
                print(error.localizedDescription)
                
                self.delegate?.landmarksNotFound(reason: .badData)
            }
        }
        
        print("execute request")
        task.resume()
    }
}
