//
//  DateButton.swift
//  E-care mobile app
//
//  Created by COCOBSCCOMPY4231P-035 on 2024-11-08.
//

import SwiftUI

struct DateButton: View {
    let day: Int
    let dayText: String
    
    var body: some View {
        VStack {
            Text("\(day)")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color.blue)
            Text(dayText)
                .font(.subheadline)
                .foregroundColor(Color.gray)
        }
        .frame(width: 50, height: 70)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

#Preview {
    DateButton(day: 9, dayText: "MON")
}
