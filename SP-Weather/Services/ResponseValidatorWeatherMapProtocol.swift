//
//  ResponseValidatorWeatherMapProtocol.swift
//  SP-Weather
//
//  Created by Shailesh Namjoshi on 30/1/18.
//  Copyright © 2018 Shailesh Namjoshi. All rights reserved.
//

import Foundation

import CoreLocation


public protocol ResponseValidatorProtocol {
    
    func getCoord() -> CLLocationCoordinate2D
    
    func getTemperature() -> Float
    
    func getPressure() -> Float
    
    func getHumidity() -> Float
    
    func getTempMax() -> Float
    
    func getTempMin() -> Float
    
    func getCityName() -> String
    
    func getIconList() -> WeatherIconList
    
    func getDescription() -> String
    
    func getWindSpeed() -> Float
    
    func getDate() -> Date
}

