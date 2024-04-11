//
//  WeatherModel.swift
//  CityWeather
//
//  Created by Oleksiy Chebotarov on 09/04/2024.
//

import Combine
import Foundation
import SwiftUI

class WeatherModel: Identifiable, ObservableObject, Hashable {
    static func == (lhs: WeatherModel, rhs: WeatherModel) -> Bool {
        return lhs.name == rhs.name &&
            lhs.maxTemperature == rhs.maxTemperature &&
            lhs.minTemperature == rhs.minTemperature &&
            lhs.temperature == rhs.temperature
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(maxTemperature)
        hasher.combine(minTemperature)
        hasher.combine(temperature)
    }

    private let response: WeatherResponse

    private func toCelcius(from kelvin: Double) -> Double {
        return kelvin - 273.15
    }

    init(response: WeatherResponse) {
        self.response = response
    }

    var name: String {
        response.name
    }

    var weather: String {
        return response.weather.first?.weather ?? ""
    }

    var weatherIconName: String {
        return response.weather.first?.iconName ?? "unknown"
    }

    var speed: String {
        return String(format: "%.1f", response.wind.speed)
    }

    var temperature: String {
        String(format: "%.0f", toCelcius(from: response.main.temperature))
    }

    var temperatureFeelsLike: String {
        String(format: "%.0f", toCelcius(from: response.main.feelsLike))
    }

    var maxTemperature: String {
        String(format: "%.0f", toCelcius(from: response.main.maxTemperature))
    }

    var minTemperature: String {
        String(format: "%.0f", toCelcius(from: response.main.minTemperature))
    }

    var humidity: String {
        return String(format: "%d", response.main.humidity)
    }

    var pressure: String {
        return String(format: "%d", response.main.pressure)
    }

    var longitude: Double {
        response.coord.lon
    }

    var latitude: Double {
        response.coord.lat
    }
}
