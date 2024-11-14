//
//  Eventos.swift
//  OcoyuTrail
//
//  Created by Valente Cisneros Gomez on 07/11/24.
//
import SwiftUI

class Eventos: Identifiable {
    var id = UUID()
    var title: String
    var info: String
    var imageName: String
    var image: Image {
        Image(imageName)
    }
    
    init(title: String, info: String, imageName: String) {
        self.title = title
        self.info = info
        self.imageName = imageName
    }
    
    // Static array for sample data
    static let sampleEvents: [Eventos] = [
        Eventos(title: "Caminata Guiada", info: "Descubre Ocoyucan con una caminata Guiada.", imageName: "caminata"),
        Eventos(title: "Taller de Cerámica", info: "Participa en un taller de Cerámica.", imageName: "ceramica"),
        Eventos(title: "Reconocimiento de Flora", info: "Capacitación para conocer la flora.", imageName: "flora"),
        Eventos(title: "Reforestación", info: "Reforestación para mejorar el aire.", imageName: "reforestacion")
    ]
}

