//
//  DetailWeatherView.swift
//  CityWeather
//
//  Created by Oleksiy Chebotarov on 09/04/2024.
//

import SwiftUI

struct DetailWeatherView: View {
    @StateObject var viewModel: WeatherModel

    var body: some View {
        ZStack {
            Background
                .ignoresSafeArea()

            VStack {
                Group {
                    Text("\(viewModel.name)")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                    WeatherWithIcon

                    Text("\(viewModel.temperature)º")
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
            Text("\(viewModel.weather)")
            Image(viewModel.weatherIconName)
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
                Text("\(viewModel.minTemperature)º")
                    .foregroundColor(.white)
            }
            HStack {
                Text("L:")
                    .foregroundColor(.white)
                Text("\(viewModel.maxTemperature)º")
                    .foregroundColor(.white)
            }
        }
        .font(.system(size: 25))
    }

    var TempFeelsLike: some View {
        HStack(alignment: .firstTextBaseline) {
            Text("Temperature feels like:")
                .font(.system(size: 20))
            Text("\(viewModel.temperatureFeelsLike)º")
                .font(.system(size: 25))
                .bold()
        }
        .foregroundColor(.white)
    }

    var AtmosphericPressure: some View {
        HStack(alignment: .firstTextBaseline) {
            Text("Atmospheric pressure:")
                .font(.system(size: 20))
            UnitsView(value: viewModel.pressure, unit: "hPa")
        }
        .foregroundColor(.white)
    }

    var Humidity: some View {
        HStack(alignment: .firstTextBaseline) {
            Text("Humidity:")
                .font(.system(size: 20))
            UnitsView(value: viewModel.humidity, unit: "%")
        }
        .foregroundColor(.white)
    }

    var WindSpeed: some View {
        HStack(alignment: .firstTextBaseline) {
            Text("Wind speed:")
                .font(.system(size: 20))
            UnitsView(value: viewModel.speed, unit: "m/sec")
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
