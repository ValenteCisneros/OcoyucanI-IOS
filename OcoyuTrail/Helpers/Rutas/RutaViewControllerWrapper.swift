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
    
    init() {
    
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(red: 0.122, green: 0.235, blue: 0.141, alpha: 1.0)
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    
    func makeUIViewController(context: Context) -> RutaViewController {
        return RutaViewController()
    }

    func updateUIViewController(_ uiViewController: RutaViewController, context: Context) {
        // Handle updates if needed
    }
    
}
