//
//  ApiNetwork.swift
//  WeatherTest
//
//  Created by Veaceslav Chirita on 6/16/20.
//  Copyright © 2020 Veaceslav Chirita. All rights reserved.
//

import Foundation
import CoreLocation

class ApiNetwork {
    static let shared = ApiNetwork()
    let API_KEY = "a6a67538b84590d5c50503ff3b51b1ce"
    let baseURL = "https://api.openweathermap.org/data/2.5/onecall?"
    
    private init() {}
    
    func getWeather(lat: CLLocationDegrees, long: CLLocationDegrees, isHourly: Bool, completed: @escaping (WeatherAPIModel?) -> Void) {
        
        var endPoint = baseURL + "appid=\(API_KEY)"
            + "&lat=\(lat)&lon=\(long)&exclude=minute"
        
        if isHourly {
            endPoint = endPoint + ",daily"
        } else {
            endPoint = endPoint + ",hourly"
        }
        
        guard let url = URL(string: endPoint) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(nil)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil)
                return
            }
            
            guard let data = data else {
                completed(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(WeatherAPIModel.self, from: data)
                completed(response)
            } catch {
                print(error.localizedDescription)
                completed(nil)
            }
        }
        task.resume()
    }
}
