//
//  CurrentWeatherResponse.swift
//  SP-Weather
//
//  Created by Shailesh Namjoshi on 30/1/18.
//  Copyright © 2018 Shailesh Namjoshi. All rights reserved.
//

import Foundation
import CoreLocation


public class CurrentWeatherResponse: WeatherAPIResponseParser,ResponseValidatorProtocol{
    
    public func getCoord() -> CLLocationCoordinate2D {
        let coord = self.rawData["coord"] as! Dictionary<String,Float>
        return CLLocationCoordinate2D(latitude: CLLocationDegrees(coord["lat"]!), longitude: CLLocationDegrees(coord["long"]!))
    }
    
    public func getTemperature() -> Float {
        let main = self.getDictionary(byKey: "main")
        return main["temp"] as! Float
    }
    
    public func getPressure() -> Float {
        let main = self.getDictionary(byKey: "main")
        return main["pressure"] as! Float
    }
    
    public func getHumidity() -> Float {
        let main = self.getDictionary(byKey: "main")
        return main["humidity"] as! Float
    }
    
    public func getTempMax() -> Float {
        let main = self.getDictionary(byKey: "main")
        return main["temp_max"] as! Float
    }
    
    public func getTempMin() -> Float {
        let main = self.getDictionary(byKey: "main")
        return main["temp_min"] as! Float
    }
    
    public func getCityName() -> String {
        return self.rawData["name"] as! String
    }
    
    public func getIconList() -> WeatherIconList {
        let weather = self.getArrayOfDictionary(byKey: "weather").first
        let icon = weather?["icon"] as! String
        return WeatherIconList(rawValue: icon)!
    }
    
    public func getDescription() -> String {
        let weather = self.getArrayOfDictionary(byKey: "weather").first
        return weather?["description"] as! String
    }
    
    public func getWindSpeed() -> Float {
        let wind = self.getDictionary(byKey: "wind")
        return wind["speed"] as! Float
    }
    
    public func getDate() -> Date {
        return Date(timeIntervalSince1970: self.rawData["dt"] as! TimeInterval)
    }
}
