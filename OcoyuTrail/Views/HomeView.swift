//
//  HomeView.swift
//  OcoyuTrailA
//
//  Created by Valente Cisneros Gomez on 30/10/24.
//
import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Color.background.edgesIgnoringSafeArea(.all)
                Text("Libreria")
                    .font(.title)
                    .foregroundColor(.primary)
                    .padding()
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


