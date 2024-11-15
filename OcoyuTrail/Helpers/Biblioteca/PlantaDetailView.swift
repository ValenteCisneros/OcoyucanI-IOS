//
//  PlantaDetailView.swift
//  OcoyuTrail
//
//  Created by Valente Cisneros Gomez on 14/11/24.
//


import SwiftUI

struct PlantaDetailView: View {
    var planta: Planta
    
    var body: some View {
        VStack {
            Image("image\(planta.id)") // Nombre de la imagen basado en el ID
                .resizable()
                .scaledToFit()
                .frame(height: 200)
            
            Text(planta.nombre)
                .font(.title)
                .padding(.top)
            
            Text("Información:")
                .font(.headline)
                .padding(.top)
            Text(planta.informacion)
                .padding(.horizontal)
            
            Text("Categoría:")
                .font(.headline)
                .padding(.top)
            Text(planta.categoria)
                .padding(.horizontal)
        }
        .padding()
        .navigationTitle(planta.nombre)
    }
}

struct PlantaDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let plantaEjemplo = Planta()
        plantaEjemplo.id = 1
        plantaEjemplo.nombre = "Cactus"
        plantaEjemplo.informacion = "Es una planta que almacena agua."
        plantaEjemplo.categoria = "Suculenta"

        return PlantaDetailView(planta: plantaEjemplo)
    }
}

