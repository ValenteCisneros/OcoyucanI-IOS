//
//  PlantaDetailView.swift
//  OcoyuTrail
//
//  Created by Valente Cisneros Gomez on 14/11/24.
//


import SwiftUI

struct PlantaDetailView: View {
    let planta: Planta
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Image("\(planta.id)")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .cornerRadius(12)
                    .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text(planta.nombre)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("Categoría: \(planta.categoria)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("Información")
                        .font(.headline)
                        .padding(.top, 8)
                    
                    Text(planta.informacion)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

