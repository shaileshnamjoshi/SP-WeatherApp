//
//  ViewController.swift
//  SP-Weather
//
//  Created by Shailesh Namjoshi on 29/1/18.
//  Copyright © 2018 Shailesh Namjoshi. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController ,CLLocationManagerDelegate {
    @IBOutlet weak var degrees: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var tempMax: UILabel!
    @IBOutlet weak var tempMin: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var location: UILabel!
    
    var currentDate = NSDate()
    var backgroundImageView: UIImageView!
    
    var apiKey : String!
    var weatherAPI : WeatherAPI!
    
    var locationManager: CLLocationManager = CLLocationManager()
    var locationObject: CLLocation?
    
    var responseWeatherApi : ResponseValidatorProtocol!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.apiKey = PlistReaderUtil.getValue(forKey: "API_WEATHER_KEY") as! String
        
        
        //Location Services
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherAPI = WeatherAPI(apiKey: self.apiKey, forType: WeatherMapType.Current)
        weatherAPI.setTemperatureUnit(unit: TemperatureFormat.Celsius)
        
        getCurrentWeatherHardCodedDataForSG()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getCurrentWeatherHardCodedDataForSG(){
        weatherAPI.weather(byLatitude: 1.283931, andLongitude: 103.85146)
        weatherAPI.performWeatherRequest(completionHandler:{(data: Data?, urlResponse: URLResponse?, error: Error?) in
            NSLog("Response Current Weather Done")
            if (error != nil) {
                self.showAddOutfitAlert(message: "Error fetching the current weather", error: error)
            } else {
                do {
                    self.responseWeatherApi = try CurrentWeatherResponse(data: data!)
                    DispatchQueue.main.async { [unowned self] in
                        self.updateViewWithResponseWeatherAPI()
                    }
                } catch let error as Error {
                    self.showAddOutfitAlert(message: "Error fetching the current weather", error: error)
                }
            }
        })
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        if self.locationObject == nil {
            self.locationObject = locations[locations.count - 1]
            let currentLatitude: CLLocationDistance = self.locationObject!.coordinate.latitude
            let currentLongitude: CLLocationDistance = self.locationObject!.coordinate.longitude
            weatherAPI.weather(byLatitude: currentLatitude, andLongitude: currentLongitude)
            weatherAPI.performWeatherRequest(completionHandler:{(data: Data?, urlResponse: URLResponse?, error: Error?) in
                NSLog("Response Current Weather Done")
                if (error != nil) {
                    self.showAddOutfitAlert(message: "Error fetching the current weather", error: error)
                } else {
                    do {
                        self.responseWeatherApi = try CurrentWeatherResponse(data: data!)
                        DispatchQueue.main.async { [unowned self] in
                            self.updateViewWithResponseWeatherAPI()
                        }
                    } catch let error as Error {
                        self.showAddOutfitAlert(message: "Error fetching the current weather", error: error)
                    }
                }
            })
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        NSLog("Impossible to get the location of the device")
    }
    
    private func updateViewWithResponseWeatherAPI(){
        self.degrees.text = String(Int(self.responseWeatherApi.getTemperature())) + "°"
        self.pressure.text = String(self.responseWeatherApi.getPressure()) + "hPa"
        self.humidity.text = String(self.responseWeatherApi.getHumidity()) + "%"
        self.tempMax.text = String(self.responseWeatherApi.getTempMax()) + "°"
        self.tempMin.text = String(self.responseWeatherApi.getTempMin()) + "°"
        self.windSpeed.text = String(self.responseWeatherApi.getWindSpeed()) + "mps"
        self.weatherLabel.text = self.responseWeatherApi.getDescription()
        self.location.text = self.responseWeatherApi.getCityName()
    }
    
    private func showAddOutfitAlert(message: String, error: Error?) {
        let alert = UIAlertController(title: "Oups!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
            print(error ?? "No error object")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func segmentedValueChanged(_ sender:UISegmentedControl!)
    {
        print("Selected Segment Index is : \(sender.selectedSegmentIndex)")
        let today = Date()
        let tomorrow = Calendar.current.date(byAdding: .day, value: sender.selectedSegmentIndex, to: today)
        weatherAPI.type = WeatherMapType.Forecast
        weatherAPI.performWeatherRequest(completionHandler:{(data: Data?, urlResponse: URLResponse?, error: Error?) in
            NSLog("Response Current Forecast Done")
            if (error != nil) {
                self.showAddOutfitAlert(message: "Error fetching the forecast weather", error: error)
            } else {
                do {
                    self.responseWeatherApi = try ForecastWeatherResponse(data: data!, date: tomorrow!)
                    DispatchQueue.main.async { [unowned self] in
                        self.updateViewWithResponseWeatherAPI()
                    }
                } catch let error as Error {
                    self.showAddOutfitAlert(message: "Error fetching the forecast weather", error: error)
                }
            }
        })
    }
    
    
}

