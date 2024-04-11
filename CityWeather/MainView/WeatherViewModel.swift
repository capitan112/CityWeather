//
//  WeatherViewModel.swift
//  CityWeather
//
//  Created by Oleksiy Chebotarov on 11/04/2024.
//

import Combine
import Foundation
import SwiftData
import SwiftUI

@Observable class WeatherViewModel {
    var searchSubject = CurrentValueSubject<String, Never>("")
    var modelContext: ModelContext

    private var httpClient: HTTPClient = .init()
    private var cancellables: Set<AnyCancellable> = []

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        setupSearchPublisher()
    }

    func setupSearchPublisher() {
        searchSubject
            .debounce(for: .seconds(0.6), scheduler: DispatchQueue.main)
            .sink { searchText in
                if !searchText.isEmpty {
                    self.loadWeather(for: searchText)
                }

            }.store(in: &cancellables)
    }

    func deleteCity(indexSet: IndexSet, cityWeathers: [WeatherObject]) {
        for index in indexSet {
            let weather = cityWeathers[index]
            modelContext.delete(weather)
        }
    }

    private func update(_ cityWeather: WeatherModel) {
        let weatherObject = WeatherObject(model: cityWeather)
        modelContext.insert(weatherObject)
    }

    func loadWeather(for city: String = "London") {
        httpClient.fetchForecast(for: city)
            .map(WeatherModel.init)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { cityWeather in
                self.update(cityWeather)
            }).store(in: &cancellables)
    }
}
