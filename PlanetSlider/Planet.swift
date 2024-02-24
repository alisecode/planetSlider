//
//  Planet.swift
//  PlanetSlider
//
//  Created by Alisa Serhiienko on 29.02.2024.
//

import SwiftUI

struct Planet: Identifiable {
    var id = UUID()
    var title: String
    var description: String
}


var planets: [Planet] = [

    .init(title: "Mercury", description: "Diameter: 4,880 kilometers"),
    .init(title: "Venus", description: "Diameter: 12,104 kilometers"),
    .init(title: "Earth", description: "Diameter: 12,742 kilometers "),
    .init(title: "Mars", description: "Diameter: 6,779 kilometers "),
    .init(title: "Jupiter", description: "Diameter: 139,820 kilometers"),
    .init(title: "Saturn", description: "Diameter: 116,460 kilometers"),
    .init(title: "Uranus", description: "Diameter: 50,724 kilometers"),
    .init(title: "Neptune", description: "Diameter: 49,244 kilometers")
]
