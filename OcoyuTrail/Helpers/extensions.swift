//
//  extensions.swift
//  OcoyuTrail
//
//  Created by Valente Cisneros Gomez on 02/11/24.
//

import Foundation

extension Int{
    func formatTimeStrig() -> String{
        let hours = self / 3600
        let minutes = (self % 3600) / 60
        let seconds = self % 3600 % 60
        
        if seconds < 0{
            return "00:00:00"
        }else {
            if hours == 0{
                return String(format: "%02d:%02d", minutes, seconds)
            }else{
                return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
            }
        }
    }
}

extension Double{
    func meterToMeter() -> Double{
        let meters = Measurement(value: self, unit: UnitLength.meters)
        return meters.converted(to: .meters).value
    }
    
    func toString(places: Int) -> String{
        return String(format: "%\(places)f", self)
    }
}
