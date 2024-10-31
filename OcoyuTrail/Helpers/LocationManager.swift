//
//  LocationManager.swift
//  OcoyuTrailA
//
//  Created by Valente Cisneros Gomez on 30/10/24.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject, CLLocationManagerDelegate {
    var manager: CLLocationManager
    
    override init() {
        manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.activityType = .fitness
        super.init()
        manager.delegate = self  
    }
    
    func checkLocationAuthorization() {
        if manager.authorizationStatus != .authorizedWhenInUse {
            manager.requestWhenInUseAuthorization()
        } else {
            startUpdatingLocation()
        }
    }
    
    func startUpdatingLocation() {
        manager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        manager.stopUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            NotificationCenter.default.post(name: .didUpdateLocation, object: self, userInfo: ["center": center])
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed: \(error.localizedDescription)")
    }
}


extension Notification.Name {
    static let didUpdateLocation = Notification.Name("didUpdateLocation")
}

