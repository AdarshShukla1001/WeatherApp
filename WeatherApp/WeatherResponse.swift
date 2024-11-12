//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by adarsh shukla on 12/11/24.
//

import Foundation

struct WeatherResponse: Codable {
    let main: Main
    let weather: [Weather]
    let name: String // City name
}

struct Main: Codable {
    let temp: Double // Temperature in Celsius
    let humidity: Int // Humidity percentage
}

struct Weather: Codable {
    let description: String // Weather description
}
