//
//  PlistReaderUtil.swift
//  SP-Weather
//
//  Created by Shailesh Namjoshi on 30/1/18.
//  Copyright © 2018 Shailesh Namjoshi. All rights reserved.
//

import Foundation

public class PlistReaderUtil {
    public static func getValue(forKey key: String) -> Any? {
        var config: NSDictionary
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
            config = NSDictionary(contentsOfFile: path)!
            return config.value(forKey: "API_WEATHER_KEY")
        }
        return nil
    }
}
