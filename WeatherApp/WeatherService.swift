//
//  WeatherService.swift
//  WeatherApp
//
//  Created by adarsh shukla on 12/11/24.
//

import Foundation

class WeatherService {
    private let apiKey = "YOUR_API_KEY"  //Replace with your API key
    
    func fetchWeather(for city: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
        
        print(urlString)
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                print("data \(data)")
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(.success(weatherResponse))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
}
