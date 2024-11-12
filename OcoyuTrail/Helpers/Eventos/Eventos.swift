//
//  Eventos.swift
//  OcoyuTrail
//
//  Created by Valente Cisneros Gomez on 07/11/24.
//
import UIKit
import SwiftUI
import SwiftData

@available(iOS 17, *)
@Model
class Eventos {
    var title: String
    var info: String
    var imageName: String
    var image: Image {
        SwiftUICore.Image(imageName)
    }
    
    init(title: String, description: String, imageName: String) {
        self.title = title
        self.info = description
        self.imageName = imageName
    }
}
