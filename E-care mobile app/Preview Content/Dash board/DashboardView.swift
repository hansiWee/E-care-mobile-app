//
//  DashboardView.swift
//  E-care mobile app
//
//  Created by COCOBSCCOMPY4231P-035 on 2024-11-08.
//

import SwiftUI

struct UserProfile: Codable {
    var username: String
    var profileImageUrl: String // URL to the user's profile image
}

struct DashboardView: View {
    
    @State private var selectedDate = "11 Wed"
    @State private var userProfile: UserProfile? // Store the fetched user profile
    @State private var isLoading = true // Indicate loading state
    
    // Sample health metrics data
    @State private var heartRate = "78 bpm"
    @State private var sleepHours = "8 hrs"
    @State private var walkingDistance = "10 km"

    var body: some View {
        VStack(spacing: 0) {
            ScrollView { // Wrap main content in ScrollView
                VStack(spacing: 20) { // Increased spacing to prevent overlap
                    // Top Greeting and User Info
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Hi, Welcome Back")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            if let userProfile = userProfile {
                                Text(userProfile.username) // Display fetched username
                                    .font(.headline)
                            } else {
                                Text("Loading...") // Placeholder while loading
                                    .font(.headline)
                            }
                        }
                        Spacer()
                        
                        if let userProfile = userProfile {
                            // Display user's profile image fetched from API
                            AsyncImage(url: URL(string: userProfile.profileImageUrl)) { image in
                                image.resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            } placeholder: {
                                ProgressView() // Loading indicator while the image is loading
                            }
                        } else {
                            // Placeholder if no profile data is available
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal)

                    // Promo Banner
                    Image("promo-banner") // Replace with actual image asset
                        .resizable()
                        .scaledToFill()
                        .frame(height: 150)
                        .clipped()
                        .padding(.horizontal)
                    
                 
                    // Calendar Section
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(9..<15) { day in
                                DateButton(day: day, dayText: "MON") // Update day names as needed
                            }
                        }
                        .padding()
                    }
                    
                    // Appointments Section
                    VStack(alignment: .leading) {
                        Text("My Appointments")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        ScrollView {
                            VStack(spacing: 15) {
                                ForEach(0..<3) { index in
                                    AppointmentCard(doctorName: "Dr. Olivia Turner, M.D.", specialization: "Dermato-Endocrinology", time: "10:00 AM")
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .frame(maxWidth: .infinity) // Make VStack take full width
                .padding(.vertical) // Add padding around main content
            }
            
            // Custom Tab Bar
            CustomTabBar(selectedTab: $selectedTab)
                .background(Color.white.shadow(radius: 5))
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            // Fetch user profile data when the view appears
            fetchUserProfile()
        }
    }
    
    // Fetch user profile from the backend API
    func fetchUserProfile() {
        guard let url = URL(string: "https://your-api.com/user-profile") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, error == nil {
                do {
                    let decodedProfile = try JSONDecoder().decode(UserProfile.self, from: data)
                    DispatchQueue.main.async {
                        self.userProfile = decodedProfile
                        self.isLoading = false
                    }
                } catch {
                    print("Failed to decode user profile: \(error)")
                }
            } else {
                print("Failed to fetch user profile: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
        task.resume()
    }
}

#Preview {
    DashboardView()
}
