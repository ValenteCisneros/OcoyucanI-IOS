//
//  Run.swift
//  OcoyuTrail
//
//  Created by Valente Cisneros Gomez on 12/11/24.
//

import Foundation
import RealmSwift

final class Run: Object {
    @objc dynamic public private(set) var id = UUID().uuidString.lowercased()
    @objc dynamic public private(set) var pace = 0
    @objc dynamic public private(set) var distance = 0.0
    @objc dynamic public private(set) var duration = 0
    @objc dynamic public private(set) var date = Date()
    
    public private(set) var locations = List<Location>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    
    override class func indexedProperties() -> [String] {
        return["pace", "date", "duration"]
    }
    convenience init(pace: Int, distance: Double, duration: Int, location: List<Location>) {
        self.init()
        self.date = Date()
        self.pace = pace
        self.distance = distance
        self.duration = duration
        self.locations = location
    }
    
    static func addRunToRealm(pace: Int, distance: Double, duration: Int, locations: List<Location>){
        Constants.realmQueue.async {
            do{
                let realm = try Realm()
                try realm.write ({
                    realm.add(Run(pace: pace, distance: distance, duration: duration, location: locations))
                    try realm.commitWrite()
                })
            } catch {
                debugPrint("Error adding run to realm: \(error)")
            }
        }
    }
    
    static func getAllRuns() -> Results<Run>? {
        do {
            let realm = try Realm()
            var runCollection = realm.objects(Run.self)
            runCollection = runCollection.sorted(byKeyPath: "date", ascending: false)
            return runCollection
        } catch {
            return nil
        }
        
    }
}
