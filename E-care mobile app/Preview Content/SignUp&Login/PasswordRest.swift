//
//  PasswordResetView.swift
//  E-care mobile app
//
//  Created by COCOBSCCOMPY4231P-035 on 2024-11-08.
//

import SwiftUI

struct PasswordResetView: View {
    @State private var newPassword = ""
    @State private var confirmPassword = ""

    var body: some View {
        VStack(spacing: 20) {
            
            Text("Set Password")
                .font(.title)
                .fontWeight(.bold)

            Text("Enter your new password below.")
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)

            SecureField("Password", text: $newPassword)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)

            SecureField("Confirm Password", text: $confirmPassword)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)

            Button(action: {
                // Reset password action
            }) {
                Text("Create New Password")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding(.top, 20)

            Spacer()
        }
        .padding()
    }
}

#Preview {
    PasswordResetView()
}

