//
//  MapViewModel.swift
//  CityWeather
//
//  Created by Oleksiy Chebotarov on 06/07/2024.
//

import MapKit
import SwiftUI

class MapViewModel: ObservableObject {
    @Published var position: MapCameraPosition
    let coordinate: CLLocationCoordinate2D
    let city: String

    init(city: String, coordinate: CLLocationCoordinate2D, span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)) {
        self.city = city
        self.coordinate = coordinate
        position = MapCameraPosition.region(MKCoordinateRegion(center: coordinate,
                                                               span: span))
    }
}
