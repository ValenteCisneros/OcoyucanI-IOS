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
    
    private var eventos: [Eventos] {
        Eventos.sampleEvents
    }

    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 0.122, green: 0.235, blue: 0.141, alpha: 1.0)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
        
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.edgesIgnoringSafeArea(.all)
                VStack {
                    SearchBar(text: $searchText, onSearch: { text in
                        filterEventos()
                    })
                    
                    List(showFilteredList ? filteredEventos : eventos) { evento in
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
                }
                .navigationTitle("Eventos")
                .navigationBarTitleDisplayMode(.inline)
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

struct EventListView_Previews: PreviewProvider {
    static var previews: some View {
        EventListView()
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
