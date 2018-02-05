//
//  WeatherAPIResponseParser.swift
//  SP-Weather
//
//  Created by Shailesh Namjoshi on 30/1/18.
//  Copyright © 2018 Shailesh Namjoshi. All rights reserved.
//

import Foundation

public class WeatherAPIResponseParser {
    
    public enum BadDataError : Error {
        case NoDataEntry
        case NoForecastList
        case SerializationIssue(Error)
        
    }
    
    var rawData : Dictionary<String, Any>!
    
    public init(data : Data) throws {
        try self.getObject(fromJSON: data)
    }
    
    private func getObject(fromJSON data:Data) throws {
        do {
            try self.rawData = JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableLeaves) as! Dictionary<String, AnyObject>
        } catch let error as NSError {
            throw BadDataError.SerializationIssue(error)
        }
        if self.rawData.count == 0 {
            throw BadDataError.NoDataEntry
        }
    }
    
    func getDictionary(byKey key: String) -> Dictionary<String, Any> {
        return self.rawData[key] as! Dictionary<String, Any>
    }
    
    func getArrayOfDictionary(byKey key:String) -> Array<Dictionary<String, Any>> {
        return self.rawData[key] as! Array<Dictionary<String, Any>>
    }
}
