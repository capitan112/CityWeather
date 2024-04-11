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
    func fetchForecast(for city: String) -> AnyPublisher<WeatherResponse, Error> {
        guard let encodedSearch = city.urlEncoded,
              let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(encodedSearch)&appid=de44747154010728e51a84882ca43698")
        else {
            return Fail(error: NetworkError.badUrl).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .mapError { error -> NetworkError in
                NetworkError.decodingError(error)
            }
            .eraseToAnyPublisher()
    }
}
