//
//  CurrentWeather.swift
//  4206_IOSproject_TsangKaPo_ChowChingHo_NgKaKin
//
//  Created by user on 11/12/2023.
//

import UIKit
import Foundation

    struct CurrentWeather: Codable {
        let coord: Coord
        let weather: [Weather]
        let main: Main
        let wind: Wind
        let clouds: Clouds
        let sys: Sys
        let timezone: Int
        let id: Int
        let name: String
        let cod: Int
    }

    struct Coord: Codable {
        let lon: Double
        let lat: Double
    }

    struct Weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }

    struct Main: Codable {
        let temp: Double
        let feelsLike: Double
        let tempMin: Double
        let tempMax: Double
        let pressure: Int
        let humidity: Int
        let seaLevel: Int?
        let grndLevel: Int?

        enum CodingKeys: String, CodingKey {
            case temp, pressure, humidity
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case seaLevel = "sea_level"
            case grndLevel = "grnd_level"
        }
    }

    struct Wind: Codable {
        let speed: Double
        let deg: Int
        //let gust: Double
    }

    struct Clouds: Codable {
        let all: Int
    }

    struct Sys: Codable {
        let type: Int
        let id: Int
        let country: String
        let sunrise: Int
        let sunset: Int
    }
