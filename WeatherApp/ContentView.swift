//
//  ContentView.swift
//  WeatherApp
//
//  Created by adarsh shukla on 11/11/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var city: String = ""
    
    var body: some View {
        VStack {
            TextField("Enter city", text: $city)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                viewModel.fetchWeather(for: city)
            }) {
                Text("Get Weather")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            if viewModel.isLoading {
                ProgressView()
                    .padding()
            }
            
            if let weather = viewModel.weather {
                Text("Weather in \(weather.name)")
                    .font(.title)
                    .padding()
                
                Text("Temperature: \(weather.main.temp)°C")
                    .font(.headline)
                
                Text("Humidity: \(weather.main.humidity)%")
                    .font(.headline)
                
                Text("Condition: \(weather.weather.first?.description ?? "")")
                    .font(.subheadline)
            }
            
            if !viewModel.errorMessage.isEmpty {
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
