//
//  WeatherResponse.swift
//  CityWeather
//
//  Created by Oleksiy Chebotarov on 09/04/2024.
//

import Combine
import Foundation
import SwiftUI

struct WeatherResponse: Decodable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let name: String
    let coord: Coordinate

    enum CodingKeys: String, CodingKey {
        case weather
        case main
        case wind
        case name
        case coord
    }

    struct Wind: Decodable {
        let speed: Double
    }

    struct Coordinate: Decodable {
        let lon: Double
        let lat: Double

        enum CodingKeys: String, CodingKey {
            case lon, lat
        }
    }

    struct Weather: Identifiable, Decodable {
        let id = UUID()
        let weather: String
        let iconName: String
        let description: String

        enum CodingKeys: String, CodingKey {
            case weather = "main"
            case iconName = "icon"
            case description
        }
    }

    struct Main: Decodable {
        let temperature: Double
        let feelsLike: Double
        let humidity: Int
        let pressure: Int
        let maxTemperature: Double
        let minTemperature: Double

        enum CodingKeys: String, CodingKey {
            case temperature = "temp"
            case feelsLike = "feels_like"
            case humidity
            case pressure
            case maxTemperature = "temp_max"
            case minTemperature = "temp_min"
        }
    }
}
