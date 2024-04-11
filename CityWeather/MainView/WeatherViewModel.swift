//
//  WeatherViewModel.swift
//  CityWeather
//
//  Created by Oleksiy Chebotarov on 11/04/2024.
//

import Combine
import Foundation
import SwiftUI

@Observable class WeatherViewModel {
    var cityWeathers: [WeatherModel] = []
    var searchSubject = CurrentValueSubject<String, Never>("")
    
    private var httpClient: HTTPClient = .init()
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
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
    
    func deleteCity(indexSet: IndexSet) {
        indexSet.forEach { cityWeathers.remove(at: $0) }
    }
    
    func moveCity(from source: IndexSet, to destination: Int) {
        cityWeathers.move(fromOffsets: source, toOffset: destination)
    }
    
    private func isContainDublicates(_ cityWeather: WeatherModel) -> Bool {
        let set = Set<String>(cityWeathers.map { $0.name })
        return set.contains(cityWeather.name)
    }
    
    private func update(_ cityWeather: WeatherModel) {
        if !self.isContainDublicates(cityWeather) {
            self.cityWeathers.append(cityWeather)
        }
    }
    
    func loadWeather(for city: String = "London") {
        Task {
            guard let response = try? await httpClient.fetchForecastAsync(for: city) else { return }
            self.update(WeatherModel(response: response))
        }            
    }
}
