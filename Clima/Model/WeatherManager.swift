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
    }
}
