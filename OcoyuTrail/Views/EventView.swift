//
//  EventView.swift
//  OcoyuTrailA
//
//  Created by Valente Cisneros Gomez on 08/10/24.
//

import SwiftUI

struct EventView: View {
    var body: some View {
        NavigationView {
            VStack {
                Color.background.edgesIgnoringSafeArea(.all)
                Text("Hello World")
                    .font(.title)
                    .foregroundColor(.primary)
                    .padding()
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(
                leading: LeadingBarItem(),
                trailing: TrailingBarItem()
            )
        }
        .statusBar(hidden: true) 
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView()
            .previewLayout(.sizeThatFits)
    }
}
