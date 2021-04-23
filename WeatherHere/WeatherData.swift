//
//  WeatherData.swift
//  WeatherHere
//
//  Created by apple on 22/04/21.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
    
}
struct Main: Decodable {
    let temp: Double
}


struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    
}
