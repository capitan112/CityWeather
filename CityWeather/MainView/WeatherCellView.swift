//
//  WeatherCellView.swift
//  CityWeather
//
//  Created by Oleksiy Chebotarov on 09/04/2024.
//

import Foundation
import SwiftUI

struct WeatherCellView: View {
    var weatherObject: WeatherObject
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            VStack(alignment: .leading) {
                Text(weatherObject.name)
                    .lineLimit(nil)
                    .truncationMode(.middle)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(.label))
                    .scaledToFit()
                    .minimumScaleFactor(0.6)
            }
            Spacer()
            VStack(alignment: .leading) {
                TemperatureView(attribute: "H", temperature: weatherObject.maxTemperature)
                TemperatureView(attribute: "L", temperature: weatherObject.minTemperature)
            }
            .frame(width: 60)
            .padding([.leading, .trailing], 5.0)

            VStack(alignment: .leading) {
                Image(systemName: "humidity")
                Text("\(weatherObject.humidity)%")
            }
            .padding([.leading, .trailing], 5.0)

            VStack(alignment: .leading) {
                Image(weatherObject.weatherIconName)
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
    WeatherCellView(weatherObject: WeatherObject(name: "London", weather: "cloud", weatherIconName: "10d", speed: "40", temperature: "15", temperatureFeelsLike: "16", maxTemperature: "22C", minTemperature: "10C", humidity: "50", pressure: "1020", longitude: -0.1257, latitude: 51.5085))
}
