//
//  WeatherObject.swift
//  CityWeather
//
//  Created by Oleksiy Chebotarov on 05/07/2024.
//

import Combine
import Foundation
import SwiftData
import SwiftUI

@Model
final class WeatherObject {
    @Attribute(.unique) var name: String
    var weather: String
    var weatherIconName: String
    var speed: String
    var temperature: String
    var temperatureFeelsLike: String
    var maxTemperature: String
    var minTemperature: String
    var humidity: String
    var pressure: String
    var longitude: Double
    var latitude: Double

    init(name: String, weather: String, weatherIconName: String, speed: String, temperature: String, temperatureFeelsLike: String, maxTemperature: String, minTemperature: String, humidity: String, pressure: String, longitude: Double, latitude: Double) {
        self.name = name
        self.weather = weather
        self.weatherIconName = weatherIconName
        self.speed = speed
        self.temperature = temperature
        self.temperatureFeelsLike = temperatureFeelsLike
        self.maxTemperature = maxTemperature
        self.minTemperature = minTemperature
        self.humidity = humidity
        self.pressure = pressure
        self.longitude = longitude
        self.latitude = latitude
    }

    convenience init(model: WeatherModel) {
        self.init(name: model.name,
                  weather: model.weather,
                  weatherIconName: model.weatherIconName,
                  speed: model.speed,
                  temperature: model.temperature,
                  temperatureFeelsLike: model.temperatureFeelsLike,
                  maxTemperature: model.maxTemperature,
                  minTemperature: model.minTemperature,
                  humidity: model.humidity,
                  pressure: model.pressure,
                  longitude: model.longitude,
                  latitude: model.latitude)
    }
}
