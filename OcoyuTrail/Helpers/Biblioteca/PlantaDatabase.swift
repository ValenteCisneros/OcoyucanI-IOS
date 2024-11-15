//
//  PlantaDatabase.swift
//  OcoyuTrail
//
//  Created by Valente Cisneros Gomez on 14/11/24.
//


import SQLite
import Foundation


class PlantaDatabase {
    private var db: Connection!
    private let plantasTable = Table("plantas")
    private let id = Expression<Int64>(value: "id")
    private let nombre = Expression<String>(value: "nombre")
    private let informacion = Expression<String>(value: "informacion")
    private let categoria = Expression<String>(value: "categoria")
    
    init() {
        // Conexión a la base de datos
        do {
            let path = Bundle.main.path(forResource: "plantas", ofType: "db")!
            db = try Connection(path, readonly: true)
        } catch {
            print("Error al conectar a la base de datos: \(error)")
        }
    }
    
    func fetchPlantas() -> [Planta] {
        var plantas: [Planta] = []
        do {
            for planta in try db.prepare(plantasTable) {
                let newPlanta = Planta()
                newPlanta.id = Int(try planta.get(id)) ?? 0
                newPlanta.nombre = try planta.get(nombre)
                newPlanta.informacion = try planta.get(informacion)
                newPlanta.categoria = try planta.get(categoria)
                plantas.append(newPlanta)
            }
        } catch {
            print("Error al obtener plantas: \(error)")
        }
        return plantas
    }
}
