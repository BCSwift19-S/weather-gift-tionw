//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by user150978 on 3/18/19.
//  Copyright © 2019 Tion. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherLocation{
    var name = ""
    var coordinates = ""
    var currentTemp = "--"
    
    func getWeather(completed: @escaping () -> ()) {
        let weatherURL = urlBase + urlAPIKey + coordinates

        Alamofire.request(weatherURL).responseJSON { response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                //print("JSON: \(json)")
                if let temperature = json["currently"]["temperature"].double{
                    print("*** temp inside = \(temperature)")
                    let roundedTemp = String(format: "%3.f", temperature)
                    self.currentTemp = roundedTemp + "°"
                } else {
                    print("could not return a temperature")
                }
            case .failure(let error):
                print(error)
            }
            completed()
        }
    }
}
