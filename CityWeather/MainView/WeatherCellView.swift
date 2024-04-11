//
//  WeatherCellView.swift
//  CityWeather
//
//  Created by Oleksiy Chebotarov on 09/04/2024.
//

import Foundation
import SwiftUI

struct WeatherCellView: View {
    var weatherModel: WeatherModel
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            VStack(alignment: .leading) {
                Text(weatherModel.name)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(.label))
                    .scaledToFit()
                    .minimumScaleFactor(0.6)
            }
            .frame(minWidth: 120, maxWidth: 140)

            VStack(alignment: .leading) {
                TemperatureView(attribute: "H", temperature: weatherModel.maxTemperature)
                TemperatureView(attribute: "L", temperature: weatherModel.minTemperature)
            }
            .frame(minWidth: 60, maxWidth: 60)
            .padding([.leading, .trailing], 5.0)

            VStack(alignment: .leading) {
                Image(systemName: "humidity")
                Text("\(weatherModel.humidity)%")
            }
            .padding([.leading, .trailing], 5.0)

            VStack(alignment: .leading) {
                Image(weatherModel.weatherIconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
            }
        }
    }
}

struct TemperatureView: View {
    var attribute: String
    var temperature: String

    var body: some View {
        HStack {
            Text("\(attribute):")
                .frame(width: 15)
            Text("\(temperature) ºC")
        }
        .minimumScaleFactor(0.6)
    }
}

#Preview {
    WeatherCellView(weatherModel: WeatherModel(response: WeatherResponse(weather: [WeatherResponse.Weather(weather: "cloud", iconName: "10d", description: "clouds")], main: .init(temperature: 50, feelsLike: 50, humidity: 50, pressure: 1020, maxTemperature: 12, minTemperature: 10), wind: .init(speed: 40), name: "London")))
}
