//
//  Panda.swift
//  MemeCreator
//
//  Created by Mehmet Tarhan on 29/04/2023.
//

import SwiftUI

struct Panda: Codable {
    var description: String
    var imageUrl: URL?

    static let defaultPanda = Panda(description: "Cute Panda",
                                    imageUrl: URL(string: "https://assets.devpubs.apple.com/playgrounds/_assets/pandas/pandaBuggingOut.jpg"))
}

struct PandaCollection: Codable {
    var sample: [Panda]
}
