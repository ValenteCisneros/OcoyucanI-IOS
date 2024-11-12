//
//  EventosListView.swift
//  OcoyuTrail
//
//  Created by Valente Cisneros Gomez on 07/11/24.
//

import SwiftUI



@available(iOS 17.0, *)
struct EventListView: View {
    @State private var searchText = ""
    @State private var filteredEventos: [Eventos] = []
    @State private var showFilteredList = false
    
    init() {
    
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(red: 0.122, green: 0.235, blue: 0.141, alpha: 1.0)
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    
    let eventos: [Eventos] = [
        Eventos(title: "Caminata Guiada", description: "Descubre Ocoyucan con una caminata Guiada por el bosque, mientras conocemos la flora de la región.", imageName: "caminata"),
        Eventos(title: "Taller de Ceramica", description: "Participa en un taller de Ceramica para apoyar a la protección del Tentzo, este taller tiene un costo de $250 mx. e incluye pintura, café y pan dulce.", imageName: "ceramica" ),
        Eventos(title: "Taller de Reconocimiento de Flora", description: "En este taller se te capacitara para conocer la flora de la región de Ocoyucan.", imageName: "flora" ),
        Eventos(title: "Taller para la Reforestación", description: "En este taller se busca reforestar la mayor cantidad posible de zonas para mejorar la calidad del aire del municipio.", imageName: "reforestacion")
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    SearchBar(text: $searchText, onSearch: { text in
                        filterEventos()
                    })
                    
                    if showFilteredList {
                        List(filteredEventos) { evento in
                            NavigationLink(destination: EventView(evento: evento)) {
                                HStack {
                                    Image(evento.imageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50)
                                    Text(evento.title)
                                        .padding()
                                        .background(Color.white.opacity(0.7))
                                        .cornerRadius(8)
                                }
                            }
                        }
                    } else {
                        List(eventos) { evento in
                            NavigationLink(destination: EventView(evento: evento)) {
                                Text(evento.title)
                                    .padding()
                                    .background(Color.white.opacity(0.7))
                                    .cornerRadius(8)
                            }
                        }
                    }
                }
                .navigationTitle("Eventos")
                .navigationBarTitleDisplayMode(.inline)
                
                .navigationBarItems(
                    leading: LeadingBarItem(),
                    trailing: TrailingBarItem())
                .statusBar(hidden: true)
                
            }
        }
    }
    
    private func filterEventos() {
        if searchText.isEmpty {
            showFilteredList = false
        } else {
            filteredEventos = eventos.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
            showFilteredList = true
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    var onSearch: (String) -> Void
    
    var body: some View {
        HStack {
            TextField("Buscar evento...", text: $text, onCommit: {
                onSearch(text)
            })
            .padding(8)
            .background(Color.white)
            .cornerRadius(8)
            .padding(.horizontal)
        }
    }
}
