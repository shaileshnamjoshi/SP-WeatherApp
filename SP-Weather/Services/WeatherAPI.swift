//
//  WeatherAPI.swift
//  SP-Weather
//
//  Created by Shailesh Namjoshi on 30/1/18.
//  Copyright © 2018 Shailesh Namjoshi. All rights reserved.
//

import Foundation
import CoreData

public class WeatherAPI {
    
    public var parameters = [String:String]()
    public var type: WeatherMapType
    
    /// Creates a new instance with the API key and the type
    ///
    /// - Parameter apiKey: The API key that is given here: https://home.openweathermap.org/api_keys
    /// - Parameter type  : The type of the call, by default will be the Current weather, see OpenWeatherMapType
    ///                     for more information about the possibles options
    public init (apiKey : String!, forType type: WeatherMapType = WeatherMapType.Current) {
        self.parameters[RequestParametersKey.apiKey.rawValue] = apiKey
        self.type = type
    }
    
    public func weather(byCityName cityName : String) {
        self.parameters[RequestParametersKey.cityName.rawValue] = cityName
    }
    
    public func weather(byCityName cityName : String, andCountryCode countryCode: String) {
        self.parameters[RequestParametersKey.cityName.rawValue] = cityName + "," + countryCode
    }
    
    /// List of city ids may be found here: https://bulk.openweathermap.org/sample/
    public func weather(byCityId cityId : Int) {
        self.parameters[RequestParametersKey.cityID.rawValue] = String(cityId)
    }
    
    public func weather(byLatitude latitude : Double, andLongitude longitude : Double) {
        self.parameters[RequestParametersKey.latitude.rawValue] = String(latitude)
        self.parameters[RequestParametersKey.longitude.rawValue] = String(longitude)
    }
    
    public func performWeatherRequest(completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {
        let request = WeatherAPIService(withType: self.type, andParameters: self.parameters)
        request.request(onCompletion: completionHandler)
    }
    
    public func resetLocationParameters() {
        self.parameters.removeValue(forKey: RequestParametersKey.cityName.rawValue)
        self.parameters.removeValue(forKey: RequestParametersKey.cityID.rawValue)
        self.parameters.removeValue(forKey: RequestParametersKey.latitude.rawValue)
        self.parameters.removeValue(forKey: RequestParametersKey.longitude.rawValue)
        self.parameters.removeValue(forKey: RequestParametersKey.zipCode.rawValue)
    }
    
    // -- Options
    
    public func setSearchAccuracy(searchAccuracy : SearchAccuracyType) {
        self.parameters[RequestParametersKey.searchAccuracy.rawValue] = searchAccuracy.rawValue
    }
    
    public func setLimitationOfResult(in limitation : Int) {
        self.parameters[RequestParametersKey.limit.rawValue] = String(limitation)
    }
    
    public func setTemperatureUnit(unit : TemperatureFormat) {
        self.parameters[RequestParametersKey.units.rawValue] = unit.rawValue
    }
    
    public func setMultilingualSupport(language : Language) {
        self.parameters[RequestParametersKey.language.rawValue] = language.rawValue
    }
}
