//
//  Data.swift
//  WeatherApp(OpenWeather)
//
//  Created by Viktor Golubenkov on 10.01.2021.
//

import Foundation

struct WeatherData: Codable {
    
    let name: String
    let main: Main
    let weather: [Weather]
    
}

struct Main: Codable {
    
    let temp: Double
    let feels_like: Double
    
}

struct Weather: Codable {

    let id: Int
    let main: String
    
}
