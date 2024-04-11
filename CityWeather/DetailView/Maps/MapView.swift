//
//  MapView.swift
//  CityWeather
//
//  Created by Oleksiy Chebotarov on 06/07/2024.
//

import MapKit
import SwiftUI

struct MapView: View {
    @State var viewModel: MapViewModel
    init(city: String, coordinate: CLLocationCoordinate2D) {
        viewModel = MapViewModel(city: city, coordinate: coordinate)
    }

    var body: some View {
        VStack {
            Map(position: $viewModel.position) {
                Annotation(viewModel.city, coordinate: viewModel.coordinate, content: {
                    VStack {
                        Image(systemName: "hand.point.down")
                            .padding(4)
                            .foregroundColor(.white)
                            .background(.indigo)
                            .cornerRadius(4.0)
                    }
                })
            }
        }
    }
}
