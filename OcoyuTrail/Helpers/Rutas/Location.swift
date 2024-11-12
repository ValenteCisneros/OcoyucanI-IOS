//
//  Location.swift
//  OcoyuTrail
//
//  Created by Valente Cisneros Gomez on 12/11/24.
//

import RealmSwift
import Foundation

final class Location: Object {
    @objc dynamic public private(set) var latitude = 0.0
    @objc dynamic public private(set) var longitude = 0.0
    
    
    convenience init(lat: Double, long: Double){
        self.init()
        self.latitude = lat
        self.longitude = long
    }
}
