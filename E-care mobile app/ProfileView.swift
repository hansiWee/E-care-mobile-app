//
//  ProfileView.swift
//  E-care mobile app
//
//  Created by COCOBSCCOMPY4231P-035 on 2024-11-08.
//

import SwiftUI

struct ProfileView: View {
    @State private var userName = "John Doe"
    @State private var userEmail = "johndoe@example.com"
    @State private var userPhone = "(123) 456-7890"
    @State private var userBio = "Short bio about the user..."
    
    var body: some View {
        VStack {
            // Profile Picture and Name
            VStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                    .padding(.top, 40)
                
                Text(userName)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 10)
            }
            
            // Form Fields for Editing Profile
            Form {
                Section(header: Text("Personal Information").font(.headline).foregroundColor(.white)) {
                    TextField("Full Name", text: $userName)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .keyboardType(.default)
                    
                    TextField("Email", text: $userEmail)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .keyboardType(.emailAddress)
                    
                    TextField("Phone", text: $userPhone)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .keyboardType(.phonePad)
                    
                    TextField("Bio", text: $userBio)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .keyboardType(.default)
                }
            }
            .listStyle(InsetGroupedListStyle())
            
            // Action Buttons
            HStack {
                Button(action: {
                    print("Save Changes")
                }) {
                    Text("Save Changes")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                
                Button(action: {
                    print("Log Out")
                }) {
                    Text("Log Out")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
        }
        .padding()
        .background(Color.blue.ignoresSafeArea())
    }
}


#Preview {
    ProfileView()
}
