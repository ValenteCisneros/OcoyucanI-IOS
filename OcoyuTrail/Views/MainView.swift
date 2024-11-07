//
//  MainView.swift
//  OcoyuTrailA
//
//  Created by Valente Cisneros Gomez on 30/10/24.
//

import SwiftUI

struct MainView: View {
    
    init(){
        UITabBar.appearance().backgroundColor = UIColor(red: 0.149, green: 0.231, blue: 0.149, alpha: 1)
        UITabBar.appearance().unselectedItemTintColor = UIColor(red: 0.918, green: 0.957, blue: 0.792, alpha: 1)

                
    }
    var body: some View {
        TabView{
            HomeView()
                .tabItem {
                    Image(systemName:"doc.text")
                        
                    Text("Biblioteca")
                }
            CamaraViewControllerWrapper()
                .tabItem {
                    Image(systemName: "camera")
                    Text("Camara")
                }
            RutaViewControllerWrapper()
                .tabItem {
                    Image(systemName: "flag.checkered")
                    Text("Rutas")
                }
            if #available(iOS 17.0, *) {
                EventListView()
                    .tabItem {
                        Image(systemName: "list.bullet.rectangle.fill")
                        Text("Eventos")
                    }
            } else {
                
            }
        }
        .zIndex(10)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
