//
//  SelectADoctor.swift
//  E-care mobile app
//
//  Created by COCOBSCCOMPY4231P-035 on 2024-11-09.
//

import SwiftUI

struct Doctor: Identifiable {
    let id = UUID()
    let name: String
    let title: String
    let specialty: String
    let profileImageName: String // Name of the profile image in assets
}

struct DoctorListView: View {
    @State private var searchText = ""
    @State private var selectedSortOption = "A–Z"
    
    // Sample doctor data
    private let doctors = [
        Doctor(name: "Alexander Bennett", title: "Ph.D.", specialty: "Dermato-Genetics", profileImageName: "doctor1"),
        Doctor(name: "Michael Davidson", title: "M.D.", specialty: "Solar Dermatology", profileImageName: "doctor2"),
        Doctor(name: "Olivia Turner", title: "M.D.", specialty: "Dermato-Endocrinology", profileImageName: "doctor3"),
        Doctor(name: "Sophia Martinez", title: "Ph.D.", specialty: "Cosmetic Bioengineering", profileImageName: "doctor4")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            // Sorting and filtering options
            HStack {
                Text("Sort By")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Button(action: { selectedSortOption = "A-Z" }) {
                    Text("A–Z")
                        .padding(.horizontal)
                        .padding(.vertical, 6)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                // Add filter buttons as needed
                ForEach(["star", "heart", "stethoscope"], id: \.self) { iconName in
                    Button(action: {}) {
                        Image(systemName: iconName)
                            .foregroundColor(.blue)
                            .frame(width: 40, height: 40)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(radius: 3)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top)
            Spacer()
            // Search Bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("search by name", text: $searchText)
                    .padding(.leading, 5)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal)
            
            Spacer()
            Spacer()
            
            // List of doctors
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(doctors) { doctor in
                        DoctorCard(doctor: doctor)
                    }
                }
                .padding(.horizontal)
            }
            
        }
    }
}

// Doctor Card View
struct DoctorCard: View {
    let doctor: Doctor
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Image(doctor.profileImageName)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .shadow(radius: 5)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Dr. \(doctor.name), \(doctor.title)")
                    .font(.headline)
                    .foregroundColor(.blue)
                Text(doctor.specialty)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                // Action buttons
                HStack(spacing: 10) {
                    Button(action: {}) {
                        Text("Info")
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    // Icons for additional actions
                    ForEach(["calendar", "info.circle", "questionmark.circle", "heart"], id: \.self) { icon in
                        Button(action: {}) {
                            Image(systemName: icon)
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 2)
        }
        .padding(.horizontal)
    }
}

#Preview {
    DoctorListView()
}
