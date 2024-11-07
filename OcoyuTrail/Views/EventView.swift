//
//  EventView.swift
//  OcoyuTrailA
//
//  Created by Valente Cisneros Gomez on 08/10/24.
//

import SwiftUI

@available(iOS 17.0, *)
struct EventView: View {
    
    var evento: Eventos  
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            RoundedRectangle(cornerRadius: 25)
                .fill(.clear)
                .background(
                    TransparentBlurView(removeFilters: true)
                        .blur(radius: 9, opaque: true)
                        .background(Color.secondaryBackground)
                )
                .clipShape(.rect(cornerRadius: 25, style: .continuous))
                .frame(height: 220)
                .frame(width: 300)
            
            VStack(alignment: .leading) {
                Text(evento.title)
                    .font(.title)
                    .bold()
                Text(evento.info)
                    .font(.body)
                    .padding(.top, 5)
                Image(evento.imageName)
                    .resizable()
                    .scaledToFit() 
                    .frame(width: 100, height: 100)
            }
            .padding(.horizontal)
        }
        .navigationTitle(evento.title)
    }
}




struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 17.0, *) {
            EventListView()
                .previewLayout(.sizeThatFits)
        } else {
            
        }
    }
}
