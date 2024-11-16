//
//  HomeView.swift
//  OcoyuTrailA
//
//  Created by Valente Cisneros Gomez on 30/10/24.
//
import SwiftUI

struct HomeView: View {
    @State private var plantas: [Planta] = []
    @State private var searchText: String = ""
    
    var filteredPlantas: [Planta] {
        if searchText.isEmpty {
            return plantas
        } else {
            return plantas.filter { planta in
                planta.nombre.lowercased().contains(searchText.lowercased()) ||
                planta.categoria.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("")
                    .padding(.top)
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Buscar flora...", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.horizontal)
                .padding(.bottom)
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(filteredPlantas) { planta in
                            NavigationLink(destination: PlantaDetailView(planta: planta)) {
                                PlantaCard(planta: planta)
                            }
                        }
                    }
                    .padding()
                }
                
                if filteredPlantas.isEmpty {
                    VStack {
                        Image(systemName: "leaf.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        Text("No se encontraron plantas")
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
            }
            .onAppear {
                self.plantas = PlantaData.getAllPlantas()
            }
            .navigationBarItems(
                leading: LeadingBarItem(),
                trailing: TrailingBarItem()
            )
        }
        .statusBar(hidden: true)
    }
}

struct PlantaCard: View {
    let planta: Planta
    
    var body: some View {
        VStack {
            Image("\(planta.id)")
                .resizable()
                .scaledToFit()
                .frame(height: 100)
                .cornerRadius(8)
            
            Text(planta.nombre)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.primary)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 4)
        }
        .padding(8)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .previewLayout(.sizeThatFits)
    }
}



