//
//  AppointmentCard.swift
//  E-care mobile app
//
//  Created by COCOBSCCOMPY4231P-035 on 2024-11-08.
//

import SwiftUI

struct AppointmentCard: View {
    var doctorName: String
    var specialization: String
    var time: String
    
    @State private var doctorProfileImage: String = "doctor-profile" // Replace with a variable that links to your API's profile image URL
    
    var body: some View {
        HStack {
            Image(doctorProfileImage) // Dynamically loaded image (can be URL from backend)
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 5) {
                Text(doctorName)
                    .fontWeight(.bold)
                Text(specialization)
                    .foregroundColor(.gray)
                Text(time)
                    .foregroundColor(.blue)
                    .font(.subheadline)
            }
            
            Spacer()
            
            Button(action: {}) {
                Text("Re-Book")
                    .padding(8)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            Button(action: {}) {
                Text("Add Review")
                    .padding(8)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 3)
    }
}


#Preview {
    AppointmentCard(doctorName: "Dr. Olivia Turner, M.D.", specialization: "Dermato-Endocrinology", time: "10:00 AM")
        .padding()
        .previewLayout(.sizeThatFits)
}
