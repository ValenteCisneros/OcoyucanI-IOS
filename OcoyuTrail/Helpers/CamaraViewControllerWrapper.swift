//
//  CamaraViewControllerWrapper.swift
//  OcoyuTrailA
//
//  Created by Valente Cisneros Gomez on 29/10/24.
//

import SwiftUI
import UIKit

// Wrapper to integrate UIViewController (RutaViewController) into SwiftUI
struct CamaraViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CamaraViewController {
        return CamaraViewController()
    }

    func updateUIViewController(_ uiViewController: CamaraViewController, context: Context) {
        // Handle updates if needed
    }
}
