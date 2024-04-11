//
//  CityWeatherApp.swift
//  CityWeather
//
//  Created by Oleksiy Chebotarov on 09/04/2024.
//

import SwiftData
import SwiftUI

@main
struct CityWeatherApp: App {
    let container: ModelContainer

    var body: some Scene {
        WindowGroup {
            WeatherView(modelContext: container.mainContext)
        }
        .modelContainer(container)
    }

    init() {
        do {
            container = try ModelContainer(for: WeatherObject.self)
        } catch {
            fatalError("Failed to create ModelContainer for Movie.")
        }
    }
}
