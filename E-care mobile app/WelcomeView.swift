//
//  WelcomeView.swift
//  E-care mobile app
//
//  Created by COCOBSCCOMPY4231P-035 on 2024-11-08.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image("front")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .padding(.top, 50)

                Text("Welcome to E-Care!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding(.top, 20)

                Text("Your personal health companion, here to help you track, manage, and improve your well-being every day.")
                    .multilineTextAlignment(.center)
                    .padding()
                    .foregroundColor(.gray)

                Spacer()

                NavigationLink(destination: MainView()) {
                    Text("Let’s get started!")
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                }
            }
            .padding()
        }
    }
}

#Preview {
    WelcomeView()
}
