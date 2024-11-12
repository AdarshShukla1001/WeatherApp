//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by adarsh shukla on 12/11/24.
//

import Foundation
import SwiftUI

class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherResponse?
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    
    private let weatherService = WeatherService()
    
    func fetchWeather(for city: String) {
        guard !city.isEmpty else {
            self.errorMessage = "Please enter a city name."
            return
        }
        
        self.isLoading = true
        self.weatherService.fetchWeather(for: city) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let weatherResponse):
                    self.weather = weatherResponse
                    self.errorMessage = ""
                case .failure(let error):
                    self.weather = nil
                    self.errorMessage = "Failed to fetch weather: \(error.localizedDescription)"
                }
            }
        }
    }
}
