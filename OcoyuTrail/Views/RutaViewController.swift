//
//  RutaViewController.swift
//  OcoyuTrailA
//
//  Created by Valente Cisneros Gomez on 13/10/24.
//

import UIKit
import SwiftUI
import MapKit

class RutaViewController: BaseViewController {
    private var locationManager = LocationManager()
    
    private lazy var startButton: BotonRuta = {
        let v = BotonRuta()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.borderWidth = 15
        v.borderColor = .white
        v.titletext = "Inicio"
        v.addTarget(self, action: #selector(startRunning), for: .touchUpInside)
        return v
    }()
    
    private lazy var topLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    
    private lazy var mapView: MKMapView = {
        let v = MKMapView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.alpha = 0.5
        v.delegate = self
        return v
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupContraints()
        
    }
    
    @objc private func startRunning(){
        let currentRunVc = CurrentRunViewController()
        currentRunVc.modalPresentationStyle = .fullScreen
        present(currentRunVc, animated: true)
    }
    
    private func setupViews(){
        locationManager.checkLocationAuthorization()
        view.addSubview(topLabel)
        view.addSubview(mapView)
        view.addSubview(startButton)
        
    }
    private func setupContraints(){
        NSLayoutConstraint.activate([
            topLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topLabel.heightAnchor.constraint(equalToConstant: 0)
        ])
        
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 8),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            startButton.widthAnchor.constraint(equalToConstant: 100),
            startButton.heightAnchor.constraint(equalToConstant: 100),
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

extension RutaViewController: MKMapViewDelegate{
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }
        
    
}
class UITabBarController : UIViewController{
    
}
