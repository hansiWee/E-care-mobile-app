//
//  ActivityCard.swift
//  E-care mobile app
//
//  Created by COCOBSCCOMPY4231P-035 on 2024-11-08.
//

import SwiftUI

struct ActivityCard: View {
    var body: some View {
        ZStack {
            Color(uiColor: .white)
                .cornerRadius(15)
                .shadow(radius: 4)

            VStack(spacing: 8) { // Adjust spacing as needed
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Daily Steps")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Text("Today")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Image(systemName: "figure.walk")
                        .foregroundColor(.blue)
                }
                
                Spacer()
                
                Text("6224")
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
            }
            .padding()
        }
        .frame(width: 160, height: 120) // Fixed width and height
    }
}

#Preview {
    ActivityCard()
}
