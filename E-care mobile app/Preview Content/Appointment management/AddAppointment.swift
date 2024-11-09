//
//  AddAppointment.swift
//  E-care mobile app
//
//  Created by COCOBSCCOMPY4231P-035 on 2024-11-09.
//

import SwiftUI

struct AppointmentView: View {
    @State private var appointmentName: String = "appointment 1"
    @State private var doctorName: String = ""
    @State private var isSelf: Bool = true
    @State private var fullName: String = "Jane Doe"
    @State private var age: String = "30"
    @State private var gender: String = "Female"
    @State private var problemDescription: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Header Section
            HStack {
                Image(systemName: "bell")
                Spacer()
                VStack(alignment: .leading) {
                    Text("Hi, Welcome Back")
                        .font(.caption)
                    Text("Hansi Wee")
                        .font(.headline)
                }
                Spacer()
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
            }
            .padding()

            // Appointment Name
            Text("Appointment name")
                .font(.headline)
            TextField("Appointment name", text: $appointmentName)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            // Doctor Selection
            Text("Doctor name")
                .font(.headline)
            Button(action: {
                // Action for selecting doctor
            }) {
                HStack {
                    Image(systemName: "stethoscope")
                    Text("Select the Doctor")
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .padding()
                .background(Color.blue.opacity(0.2))
                .cornerRadius(10)
            }
            TextField("Dr. Doctor Name", text: $doctorName)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            // Patient Details
            Text("Patient Details")
                .font(.headline)
            Picker("Who is this appointment for?", selection: $isSelf) {
                Text("Yourself").tag(true)
                Text("Another Person").tag(false)
            }
            .pickerStyle(SegmentedPickerStyle())

            TextField("Full Name", text: $fullName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Age", text: $age)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            // Gender Selection
            HStack {
                Text("Gender")
                    .font(.headline)
                Picker("Gender", selection: $gender) {
                    Text("Male").tag("Male")
                    Text("Female").tag("Female")
                    Text("Other").tag("Other")
                }
                .pickerStyle(SegmentedPickerStyle())
            }

            // Problem Description
            TextEditor(text: $problemDescription)
                .frame(height: 100)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.5)))

            // Save Button
            Button(action: {
                // Action for saving appointment
            }) {
                Text("Save & Continue")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            // Bottom Navigation
            HStack {
                Spacer()
                Image(systemName: "house.fill")
                Spacer()
                Image(systemName: "heart.fill")
                Spacer()
                Image(systemName: "calendar")
                Spacer()
                Image(systemName: "message.fill")
                Spacer()
            }
            .padding()
            .background(Color.blue.opacity(0.2))
        }
        .padding()
    }
}


#Preview {
    AppointmentView()
}
