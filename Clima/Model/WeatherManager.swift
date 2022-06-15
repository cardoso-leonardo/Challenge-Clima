//
//  WeatherManager.swift
//  Clima
//
//  Created by Leonardo Cardoso on 14/06/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation


struct WeatherManager {
    let apiUrl = "https://api.openweathermap.org/data/2.5/weather?appid=ec296ef06bb381ebdc961ef271118202&units=metric"
    
    func fetchWeather(cityName: String) {
        let fullUrl = "\(apiUrl)&q=\(cityName)"
        performFetch(fullUrl: fullUrl)
    }
    
    func performFetch(fullUrl: String) {
        
        // Criar URL()
        if let url = URL(string: fullUrl) {
            // Criar uma sessão
            let session = URLSession(configuration: .default)
            // Criar uma dataTask
            let task = session.dataTask(with: url, completionHandler: handler(data:url:error:) )
            // Resumir a task pois o seu estado inicial é suspended
            task.resume()
        }
        
    }
    
    func handler(data: Data?,url: URLResponse?,error: Error?) -> Void {
        if (error != nil) {
            return
        }
        if let dataString = String(data: data!, encoding: .utf8) {
            print(dataString)
        }
    }
}
