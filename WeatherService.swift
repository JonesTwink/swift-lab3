//
//  WeatherService.swift
//  lab3
//
//  Created by Admin on 08.04.17.
//  Copyright © 2017 arthur. All rights reserved.
//

import Foundation
import Alamofire
let parameters: Parameters = ["bbox":"24,51,31,56,10","appid":"8c102a220ad52472bdf1cf0f18742368"]
let uri: String = "http://api.openweathermap.org/data/2.5/box/city"
public class WeatherService{
    
    static var lastFetchedData: [AnyObject] = []
    public static func getRawWeatherArray(callback: @escaping (_ result:[AnyObject])->()){
        var rawData: [AnyObject] = []
        Alamofire.request(uri, parameters: parameters).responseJSON { response in
            if let regions = response.result.value {
                let responseData = regions as! NSDictionary
                rawData =  (responseData["list"] as! [AnyObject])
                self.lastFetchedData = rawData
                callback(rawData)
            }
    
        }
        
    }
    
    
    public static func findNearestPlace(lat: Double, lon: Double)->[String:String]{
        var minDistance:Double = 999
        var closestRegion: NSDictionary = [:]
        for region in lastFetchedData{
            let regionLat = (region["coord"] as! NSDictionary)["Lat"] as! Double
            let regionLon = (region["coord"] as! NSDictionary)["Lon"] as! Double
            let distance = calcDistance(regionLat:regionLat, regionLon:regionLon, currentLat: lat, currentLon: lon);
            if (distance < minDistance){
                minDistance = distance
                closestRegion = region as! NSDictionary
            }
            
        }
        return formatArray(data: closestRegion)
    }
    
    static func calcDistance(regionLat:Double, regionLon:Double, currentLat:Double, currentLon:Double)->Double{
        let width = regionLat - currentLat
        let height = regionLon - currentLon
        
        let distance = sqrt(pow(width, 2) + pow(height, 2))
        return distance
        
    }
    static func formatArray(data: NSDictionary)->[String:String]{
        let region = data["name"] as! String
        let temperature = (String(lround((data["main"]as? NSDictionary)?["temp"] as! Double))) + "°C"
        let wind = data["wind"] as? NSDictionary
        let description = "Ветер " + (wind?["speed"] as! NSNumber).stringValue + " м/с"
        let coords = data["coord"] as? NSDictionary
        let geoLon = (coords?["Lon"] as! NSNumber).stringValue
        let geoLat = (coords?["Lat"] as! NSNumber).stringValue
        return ["region":region, "temperature":temperature, "description":description, "geoLon":geoLon, "geoLat":geoLat]
    }
    
}
