//
//  WeatherView.swift
//  CityWeather
//
//  Created by Oleksiy Chebotarov on 09/04/2024.
//

import Combine
import SwiftUI

@Observable class NavigationState {
    var routes = NavigationPath()
}

struct WeatherView: View {
    @State var viewModel = WeatherViewModel()
    @State private var navigationState = NavigationState()
    @State private var search: String = ""
    
    var body: some View {
        NavigationStack(path: $navigationState.routes) {
            ZStack {
                BackgroundView
                    .ignoresSafeArea()
                List {
                    ForEach(viewModel.cityWeathers) { cityWeather in
                        Button(action: {
                            navigationState.routes.append(cityWeather)
                        }, label: {
                            WeatherCellView(weatherModel: cityWeather)
                        })
                        .listRowBackground(Color.clear)
                    }
                    
                    .onDelete(perform: viewModel.deleteCity)
                    .onMove(perform: viewModel.moveCity)
                    .frame(height: 45)
                }
                .scrollContentBackground(.hidden)
                .listStyle(.grouped)
                .toolbar {
                    EditButton()
                }
                .onAppear {
                    viewModel.loadWeather()
                }
                .searchable(text: $search, placement: .navigationBarDrawer, prompt: "Add cities")
                .onChange(of: search) {
                    viewModel.searchSubject.send(search)
                }
                .onSubmit(of: .search) {
                    search = ""
                }
                .navigationDestination(for: WeatherModel.self) { cityWeather in  DetailWeatherView(viewModel: cityWeather)
                }
                .navigationTitle("Weather")
                .toolbarBackground(.hidden)
            }
        }
        .accentColor(Color(.darkText))
    }
}

extension WeatherView {
    var BackgroundView: some View {
        LinearGradient(colors: [Color(red: 71 / 255, green: 110 / 255, blue: 168 / 255),
                                Color(red: 173 / 255, green: 207 / 255, blue: 246 / 255)],
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
    }
}

#Preview {
    WeatherView()
}
