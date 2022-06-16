//
//  WeatherManager.swift
//  Clima
//
//  Created by Leonardo Cardoso on 14/06/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let apiUrl = "https://api.openweathermap.org/data/2.5/weather?appid=ec296ef06bb381ebdc961ef271118202&units=metric"
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let fullUrl = "\(apiUrl)&q=\(cityName)"
        performFetch(with: fullUrl)
    }
    
    func fetchWeather(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        let fullUrl = "\(apiUrl)&lat=\(lat)&lon=\(lon)"
        performFetch(with: fullUrl)
    }
    
    func performFetch(with fullUrl: String) {
        
        // Criar URL()
        if let url = URL(string: fullUrl) {
            // Criar uma sessão
            let session = URLSession(configuration: .default)
            // Criar uma dataTask
            let task = session.dataTask(with: url) { data, response, error in
                if (error != nil) {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weatherData = self.parseJSON(safeData) {
                        delegate?.didUpdateWeather(self, weather: weatherData)
                    }
                }
            }
            // Resumir a task pois o seu estado inicial é suspended
            task.resume()
        }
        
    }
    
    func parseJSON(_ data: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            return WeatherModel(conditionId: id, name: name, temperature: temp)
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }

}
