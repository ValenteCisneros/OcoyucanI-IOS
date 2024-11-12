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
        
        let effect: UIBlurEffect
        if removeFilters {
            effect = UIBlurEffect(style: .extraLight)
        } else {
            effect = UIBlurEffect(style: .regular)
        }
        
        let blurView = UIVisualEffectView(effect: effect)
        blurView.backgroundColor = UIColor.clear

        return blurView
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
        if removeFilters {
            uiView.effect = UIBlurEffect(style: .extraLight)
        } else {
            uiView.effect = UIBlurEffect(style: .regular)
        }
    }
}
