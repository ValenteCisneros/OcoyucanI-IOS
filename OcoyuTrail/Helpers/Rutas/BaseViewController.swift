//
//  BaseViewController.swift
//  OcoyuTrailA
//
//  Created by Valente Cisneros Gomez on 30/10/24.
//

import UIKit

class BaseViewController : UIViewController {
    private lazy var backgroundLayer: GradientView = {
        let gradientColors: [UIColor] = [
            UIColor(red: 38/255, green: 59/255, blue: 38/255, alpha: 1.0),
            UIColor(red: 36/255, green: 126/255, blue: 61/255, alpha: 1.0),
            UIColor(red: 151/255, green: 197/255, blue: 55/255, alpha: 1.0),
            UIColor(red: 234/255, green: 244/255, blue: 202/255, alpha: 1.0)
                ]
        let v = GradientView(colors: gradientColors)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupViews()
        SetupConstraints()
    }
    private func SetupViews() {
        view.addSubview(backgroundLayer)
    }
    private func SetupConstraints() {
        NSLayoutConstraint.activate([
            backgroundLayer.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundLayer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundLayer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundLayer.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
            }
    
    
    
}
