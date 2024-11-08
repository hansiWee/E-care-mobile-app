//
//  beActiveTabView.swift
//  E-care mobile app
//
//  Created by COCOBSCCOMPY4231P-035 on 2024-11-08.
//

import SwiftUI

struct beActiveTabView: View {
    @State var selectedTab = "Home"
    var body: some View {
        HomeView()
            .tag("Home")
            .tabItem {
                Image(systemName: "house")
            }
        ContentView()
            .tag("content")
            .tabItem {  Image(systemName: "person") }
    }
}

#Preview {
    beActiveTabView()
}
