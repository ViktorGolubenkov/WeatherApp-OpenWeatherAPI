//
//  Model.swift
//  WeatherApp(OpenWeather)
//
//  Created by Viktor Golubenkov on 10.01.2021.
//

import Foundation

struct WeatherModel {
    
    let conditionId: Int
    let descriptionTheWeather: String
    let cityName: String
    let temperature: Double
    let feelsLike: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    var feelsLikeString: String {
        return String(format: "%1.f", feelsLike)
    }
      
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
            return "cloud"
        }
        
    }   
    
}
