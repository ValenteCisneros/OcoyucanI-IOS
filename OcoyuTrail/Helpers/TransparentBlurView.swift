//
//  TransparentBlurView.swift
//  OcoyuTrail
//
//  Created by Valente Cisneros Gomez on 07/11/24.
//

import SwiftUI
import UIKit

struct TransparentBlurView: UIViewRepresentable {
    var removeFilters: Bool
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        // Configure the blur effect
        let effect: UIBlurEffect
        if removeFilters {
            effect = UIBlurEffect(style: .extraLight) // Lighter blur
        } else {
            effect = UIBlurEffect(style: .regular) // Regular blur
        }
        
        let blurView = UIVisualEffectView(effect: effect)
        blurView.backgroundColor = UIColor.clear // Optional: Transparent background color

        return blurView
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        // Update the blur effect based on the `removeFilters` property
        if removeFilters {
            uiView.effect = UIBlurEffect(style: .extraLight)
        } else {
            uiView.effect = UIBlurEffect(style: .regular)
        }
    }
}
