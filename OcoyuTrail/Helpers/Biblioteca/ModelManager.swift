//
//  ModelManager.swift
//  OcoyuTrail
//
//  Created by Valente Cisneros Gomez on 14/11/24.
//

import Foundation

let sharedInstance = ModelManager()

class ModelManager: NSObject {
    var database: FMDatabase?
    
    class var instance: ModelManager {
        let documentsFolder = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let path = documentsFolder.appending("respaldo.sql")
        sharedInstance.database = FMDatabase(path: path)
        return sharedInstance
    }
    func createDatabse() -> Bool{
        sharedInstance.database?.open()
        let isCreated = sharedInstance.database!.executeUpdate("CREATE TABLE IF NOT EXISTS planta(id INTEGER PRIMARY KEY, nombre TEXT, informacion TEXT, categoria TEXT)",
        withArgumentsIn: [])
        sharedInstance.database!.close()
        return isCreated
    }
    func addPlant(nombre: String, informacion: String, categoria: String ) -> Bool{
        sharedInstance.database!.open()
        let isInserted = sharedInstance.database!.executeUpdate("INSERT INTO planta(nombre, informacion, categoria) VALUES(?,?,?)", withArgumentsIn: [nombre, informacion, categoria])
        sharedInstance.database!.close()
        return isInserted
    }
    func findPlant(nombre: String) -> Planta {
        let planta = Planta()
        sharedInstance.database!.open()
        let resultSet = sharedInstance.database!.executeQuery("SELECT * FROM planta WHERE nombre = ?", withArgumentsIn: [nombre])
        if resultSet != nil && (resultSet?.next())! {
            planta.id = Int((resultSet!.int(forColumn: "id")))
            planta.nombre = nombre
            planta.informacion = resultSet?.string(forColumn: "informacion") ?? ""
            planta.categoria = resultSet?.string(forColumn: "categoria") ?? ""
                        
        }
        sharedInstance.database!.close()
        return planta
    }
    
    
}

