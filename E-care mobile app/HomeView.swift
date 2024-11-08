//
//  HomeView.swift
//  E-care mobile app
//
//  Created by COCOBSCCOMPY4231P-035 on 2024-11-08.
//

import SwiftUI

struct HomeView: View {
    let columns = [GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20)]
    
    var body: some View {
        ScrollView {
            LazyHGrid(rows: columns, spacing: 20) {
                ActivityCard()
                ActivityCard()
            }
            .padding()
        }
    }
}

#Preview {
    HomeView()
}

