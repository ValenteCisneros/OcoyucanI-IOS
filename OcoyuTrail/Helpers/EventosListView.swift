//
//  EventosListView.swift
//  OcoyuTrail
//
//  Created by Valente Cisneros Gomez on 07/11/24.
//

import SwiftUI

@available(iOS 17.0, *)
struct EventListView: View {
    let eventos: [Eventos] = [
        Eventos(title: "Evento 1", description: "Descripción del evento 1", imageName: "logo"),
        Eventos(title: "Evento 2", description: "Descripción del evento 2", imageName: "logo"),
        Eventos(title: "Evento 3", description: "Descripción del evento 3", imageName: "logo"),
        Eventos(title: "Evento 4", description: "Descripción del evento 4", imageName: "logo")
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                List(eventos) { evento in
                    NavigationLink(destination: EventView(evento: evento)) {
                        Text(evento.title)
                            .padding()
                            .background(Color.white.opacity(0.7))
                            .cornerRadius(8)
                    }
                }
                .navigationTitle("Eventos")
            }
        }
    }
}

