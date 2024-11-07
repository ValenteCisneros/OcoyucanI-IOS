//
//  RutaViewControllerWrapper.swift
//  OcoyuTrailA
//
//  Created by Valente Cisneros Gomez on 13/10/24.
//


import SwiftUI
import UIKit

// Wrapper to integrate UIViewController (RutaViewController) into SwiftUI
struct RutaViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> RutaViewController {
        return RutaViewController()
    }

    func updateUIViewController(_ uiViewController: RutaViewController, context: Context) {
        // Handle updates if needed
    }
}
