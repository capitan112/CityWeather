//
//  HTTPClient.swift
//  CityWeather
//
//  Created by Oleksiy Chebotarov on 09/04/2024.
//

import Combine
import Foundation
import SwiftUI

enum NetworkError: Error {
    case badUrl
    case sessionError(Error)
    case decodingError(Error)
}

class HTTPClient {
    @MainActor
    func fetchForecastAsync(for city: String) async throws -> WeatherResponse {
        guard let encodedSearch = city.urlEncoded,
              let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(encodedSearch)&appid=de44747154010728e51a84882ca43698")
        else {
            throw NetworkError.badUrl
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            return try JSONDecoder().decode(WeatherResponse.self, from: data)
        } catch  {
            throw NetworkError.decodingError(error)
        }
    }
}
