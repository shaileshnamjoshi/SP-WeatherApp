//
//  WeatherRequestParameters.swift
//  SP-Weather
//
//  Created by Shailesh Namjoshi on 30/1/18.
//  Copyright © 2018 Shailesh Namjoshi. All rights reserved.
//

import Foundation

public enum WeatherMapType : String {
    
    case Current = "weather"
    case Forecast = "forecast"
}

public enum RequestParametersKey : String {
    
    case apiKey = "appid",
    cityName = "q",
    cityID = "id",
    latitude = "lat",
    longitude = "lon",
    zipCode = "zip",
    cluster = "cluster",
    format = "mode",
    searchAccuracy = "type",
    limit = "cnt",
    units = "units",
    language = "lang"
}

public enum TemperatureFormat: String {
    case Celsius = "metric",
    Fahrenheit = "imperial",
    Kelvin = ""
}

public enum Language : String {
    case English = "en",
    Russian = "ru",
    Italian = "it",
    Spanish = "es",
    Ukrainian = "uk",
    German = "de",
    Portuguese = "pt",
    Romanian = "ro",
    Polish = "pl",
    Finnish = "fi",
    Dutch = "nl",
    French = "fr",
    Bulgarian = "bg",
    Swedish = "sv",
    ChineseTraditional = "zh_tw",
    ChineseSimplified = "zh_cn",
    Turkish = "tr",
    Croatian = "hr",
    Catalan = "ca"
}

public enum Format : String {
    case Json = "json",
    Xml = "xml",
    Html = "html"
}

public enum SearchAccuracyType : String {
    case Like = "like",
    Accurate = "accurate"
}



