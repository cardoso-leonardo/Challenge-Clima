//
//  WeatherData.swift
//  Clima
//
//  Created by Leonardo Cardoso on 15/06/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable{
    let name: String
    let main : Main
    let weather : [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let id: Int
}
