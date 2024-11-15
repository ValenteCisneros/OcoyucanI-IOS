//
//  HomeView.swift
//  OcoyuTrailA
//
//  Created by Valente Cisneros Gomez on 30/10/24.
//
import SwiftUI

struct HomeView: View {
    @State private var plantas: [Planta] = []
    private let db = PlantaDatabase()

    var body: some View {
        NavigationView {
            VStack {
                Color.background.edgesIgnoringSafeArea(.all)
                Text("Librería")
                    .font(.title)
                    .foregroundColor(.primary)
                    .padding()
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        ForEach(plantas, id: \.id) { planta in
                            NavigationLink(destination: PlantaDetailView(planta: planta)) {
                                VStack {
                                    Image("image\(planta.id)") // Usa nombres secuenciales para las imágenes
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 100)
                                    Text(planta.nombre)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                }
                                .padding()
                            }
                        }
                    }
                }
                .padding()
            }
            .onAppear {
                self.plantas = db.fetchPlantas()
            }
            .navigationBarItems(
                leading: LeadingBarItem(),
                trailing: TrailingBarItem()
            )
        }
        .statusBar(hidden: true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .previewLayout(.sizeThatFits)
    }
}



