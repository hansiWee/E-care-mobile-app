//
//  MainView.swift
//  E-care mobile app
//
//  Created by COCOBSCCOMPY4231P-035 on 2024-11-08.
//

import SwiftUI

struct MainView: View {
    @Binding var isUserLoggedIn: Bool
    var body: some View {
        TabView {
            // Dashboard Tab
            DashboardView()
                .tabItem {
                    Image(systemName: "house.fill") // Use a system icon for the dashboard
                    Text("Dashboard")
                }
            
            // Health Tab
            HealthView()
                .tabItem {
                    Image(systemName: "heart.fill") // Use a heart icon for health
                    Text("Health")
                }
            
            // Add Appointment Tab
            AddAppointmentView()
                .tabItem {
                    Image(systemName: "plus.circle.fill") // Plus icon for adding appointments
                    Text("Add Appointment")
                }
            
            // Notifications Tab
            NotificationsView()
                .tabItem {
                    Image(systemName: "bell.fill") // Bell icon for notifications
                    Text("Notifications")
                }
            
            // Profile Tab
            ProfileView(isUserLoggedIn: $isUserLoggedIn) // Pass the actual binding here
                           .tabItem {
                               Image(systemName: "person.fill") // Person icon for profile
                               Text("Profile")
                           }
        }
        .accentColor(.blue) // Change the active tab icon color (optional)
    }
}

#Preview {
    MainView(isUserLoggedIn: .constant(false))
}
