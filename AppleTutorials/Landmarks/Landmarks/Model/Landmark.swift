//
//  Landmark.swift
//  Landmarks
//
//  Created by Mehmet Tarhan on 27/04/2023.
//

import Foundation
import SwiftUI

/*
 Adding Codable conformance makes it easier to move data between the structure and a data file.
 You’ll rely on the Decodable component of the Codable protocol later in this section to read data from file.
 */
struct Landmark: Hashable, Codable {
    var id: Int
    var name: String
    var park: String
    var state: String
    var description: String

    private var imageName: String

    var image: Image {
        Image(imageName)
    }

    private var coordinate: Coordinates

    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
}
