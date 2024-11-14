//
//  RutaViewController.swift
//  OcoyuTrailA
//
//  Created by Valente Cisneros Gomez on 13/10/24.
//

import UIKit
import SwiftUI
import MapKit

class RutaViewController: RutaBar {
    

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
    
    private lazy var historyButton: BotonHistorial = {
        let v = BotonHistorial()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.borderWidth = 5
        v.borderColor = .white
        if let logoImage = UIImage(systemName: "location.north.fill") {
            v.setImage(logoImage, for: .normal)
        }
        v.addTarget(self, action: #selector(showHistory), for: .touchUpInside)
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
        v.alpha = 0.8
        v.delegate = self
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupContraints()
        setupNavigationBar()
    }
    
    @objc private func startRunning() {
        let currentRunVc = CurrentRunViewController()
        currentRunVc.modalPresentationStyle = .fullScreen
        present(currentRunVc, animated: true)
    }
    
    @objc private func showHistory() {
        let historyVC = HistoryViewController()
        historyVC.modalPresentationStyle = .fullScreen
        present(historyVC, animated: true)
    }
    
    private func setupViews() {
        locationManager.checkLocationAuthorization()
        view.addSubview(topLabel)
        view.addSubview(mapView)
        view.addSubview(startButton)
        view.addSubview(historyButton)
    }
    
    private func setupContraints() {
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
        
        NSLayoutConstraint.activate([
            historyButton.widthAnchor.constraint(equalToConstant: 50),
            historyButton.heightAnchor.constraint(equalToConstant: 50),
            historyButton.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -5),
            historyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 50)
        ])
    }
    private func setupNavigationBar() {
        // Configurar la apariencia de la barra de navegación
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground // O el color que prefieras
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // Crear los items de la barra de navegación
        let leadingController = UIHostingController(rootView: LeadingBarItem())
        let trailingController = UIHostingController(rootView: TrailingBarItem())
        
        // Ajustar el tamaño preferido de las vistas
        leadingController.view.backgroundColor = .clear
        trailingController.view.backgroundColor = .clear
        
        // Crear los UIBarButtonItems
        let leadingItem = UIBarButtonItem(customView: leadingController.view)
        let trailingItem = UIBarButtonItem(customView: trailingController.view)
        
        // Asignar los items
        navigationItem.leftBarButtonItem = leadingItem
        navigationItem.rightBarButtonItem = trailingItem
        
        // Ocultar la barra de estado
        setNeedsStatusBarAppearanceUpdate()
    }

    // Agregar esto para ocultar la barra de estado
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

extension RutaViewController: MKMapViewDelegate {
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }
}


class UITabBarController : UIViewController{
    
}


