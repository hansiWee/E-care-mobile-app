//
//  LoginView.swift
//  E-care mobile app
//
//  Created by COCOBSCCOMPY4231P-035 on 2024-11-08.
//

import SwiftUI

struct LoginView: View {
    @State private var mobileNumber = ""
    @State private var password = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Hello!")
                .font(.title)
                .fontWeight(.bold)

            TextField("Mobile Number", text: $mobileNumber)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)

            SecureField("Password", text: $password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)

            Button(action: {
                // Log in action
            }) {
                Text("Log In")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }

            Text("or")
                .foregroundColor(.gray)

            Button(action: {
                // Continue with Apple action
            }) {
                Label("Continue With Apple", systemImage: "applelogo")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(8)
            }

            Spacer()

            Button(action: {
                // Navigate to Sign Up screen
            }) {
                Text("Don't have an account? Sign Up")
                    .foregroundColor(.blue)
            }
        }
        .padding()
    }
}

#Preview {
    LoginView()
}
