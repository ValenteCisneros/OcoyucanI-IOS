//
//  BarItems.swift
//  OcoyuTrailA
//
//  Created by Valente Cisneros Gomez on 30/10/24.
//

import SwiftUI

struct LeadingBarItem: View {
    var body: some View {
        Image("logo")
            .resizable()
            .frame(width: 70, height: 70)
            .offset(y: -20)
    }
}

struct TrailingBarItem: View {
    var body: some View {
        EmptyView() 
    }
}
