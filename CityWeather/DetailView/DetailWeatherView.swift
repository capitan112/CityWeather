//
//  DetailWeatherView.swift
//  CityWeather
//
//  Created by Oleksiy Chebotarov on 09/04/2024.
//

import MapKit
import SwiftUI

struct DetailWeatherView: View {
    var weatherObject: WeatherObject

    var body: some View {
        ZStack {
            Background
                .ignoresSafeArea()
            VStack {
                Group {
                    Text("\(weatherObject.name)")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .padding(.top)
                    WeatherWithIcon

                    Text("\(weatherObject.temperature)º")
                        .font(.system(size: 100))
                        .foregroundColor(.white)
                    MinAndMaxTemp
                }
                Divider()
                Group {
                    VStack(alignment: .leading) {
                        TempFeelsLike
                            .padding(.bottom, 5)
                        AtmosphericPressure
                            .padding(.bottom, 5)
                        Humidity
                            .padding(.bottom, 5)
                        WindSpeed
                            .padding(.bottom, 5)
                    }
                }
                MapView(city: weatherObject.name, coordinate: CLLocationCoordinate2D(latitude: weatherObject.latitude, longitude: weatherObject.longitude))
                Spacer()
            }
        }
        .accentColor(Color(.darkText))
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension DetailWeatherView {
    var Background: some View {
        LinearGradient(colors: [Color(red: 71 / 255, green: 110 / 255, blue: 168 / 255),
                                Color(red: 173 / 255, green: 207 / 255, blue: 246 / 255)],
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
    }

    var WeatherWithIcon: some View {
        HStack {
            Text("\(weatherObject.weather)")
            Image(weatherObject.weatherIconName)
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .foregroundColor(.white)
        }
        .foregroundColor(.white)
        .font(.system(size: 25))
    }

    var MinAndMaxTemp: some View {
        HStack(spacing: 15) {
            HStack {
                Text("H:")
                    .foregroundColor(.white)
                Text("\(weatherObject.minTemperature)º")
                    .foregroundColor(.white)
            }
            HStack {
                Text("L:")
                    .foregroundColor(.white)
                Text("\(weatherObject.maxTemperature)º")
                    .foregroundColor(.white)
            }
        }
        .font(.system(size: 25))
    }

    var TempFeelsLike: some View {
        HStack(alignment: .firstTextBaseline) {
            Text("Temperature feels like:")
                .font(.system(size: 20))
            Text("\(weatherObject.temperatureFeelsLike)º")
                .font(.system(size: 25))
                .bold()
        }
        .foregroundColor(.white)
    }

    var AtmosphericPressure: some View {
        HStack(alignment: .firstTextBaseline) {
            Text("Atmospheric pressure:")
                .font(.system(size: 20))
            UnitsView(value: weatherObject.pressure, unit: "hPa")
        }
        .foregroundColor(.white)
    }

    var Humidity: some View {
        HStack(alignment: .firstTextBaseline) {
            Text("Humidity:")
                .font(.system(size: 20))
            UnitsView(value: weatherObject.humidity, unit: "%")
        }
        .foregroundColor(.white)
    }

    var WindSpeed: some View {
        HStack(alignment: .firstTextBaseline) {
            Text("Wind speed:")
                .font(.system(size: 20))
            UnitsView(value: weatherObject.speed, unit: "m/sec")
        }
        .foregroundColor(.white)
    }

    @ViewBuilder
    func UnitsView(value: String, unit: String) -> some View {
        HStack {
            Text("\(value)")
                .font(.system(size: 22))
                .bold()
            Text("\(unit)")
                .font(.system(size: 20))
        }
    }
}
