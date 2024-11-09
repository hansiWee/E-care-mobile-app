//
//  AddAppointmentView.swift
//  E-care mobile app
//
//  Created by COCOBSCCOMPY4231P-035 on 2024-11-08.
//

import SwiftUI
import FirebaseFirestore

struct AddAppointmentView: View {
    @State private var title = ""
    @State private var location = ""
    @State private var date = Date()
    @State private var notes = ""
    @State private var errorMessage = ""
    @State private var isShowingConfirmation = false
    @State private var navigateToMain = false 
    
    // Firestore reference
    private var db = Firestore.firestore()

    var body: some View {
            NavigationView {
                ScrollView {
                    VStack(spacing: 20) {
                        Text("Add New Appointment")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        // Title Field
                        TextField("Appointment Title", text: $title)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            .autocapitalization(.words)
                            .disableAutocorrection(true)
                        
                        // Location Field
                        TextField("Location", text: $location)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            .autocapitalization(.words)
                            .disableAutocorrection(true)
                        
                        // Date Picker
                        DatePicker("Date & Time", selection: $date, displayedComponents: [.date, .hourAndMinute])
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                        
                        // Notes Field
                        TextField("Notes (optional)", text: $notes)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            .autocapitalization(.sentences)
                            .disableAutocorrection(true)
                        
                        // Error Message
                        if !errorMessage.isEmpty {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .padding(.top, 10)
                        }
                        
                        // Save Button
                        Button(action: {
                            addAppointment()
                        }) {
                            Text("Save Appointment")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                        .padding(.top, 10)
                        .alert("Appointment Added", isPresented: $isShowingConfirmation) {
                            Button("OK", role: .cancel) {
                                // Navigate to MainView when OK is pressed
                                navigateToMain = true
                            }
                        } message: {
                            Text("Your appointment has been added successfully!")
                        }
                        
                        Spacer()
                    }
                    .padding()
                    
                    // Navigation Link to MainView
                    NavigationLink("", destination: MainView(), isActive: $navigateToMain)
                }
                .navigationTitle("Add Appointment")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    
    // Add Appointment Logic
    func addAppointment() {
        // Clear previous error
        errorMessage = ""
        
        // Validation
        guard !title.isEmpty, !location.isEmpty else {
            errorMessage = "Please fill in all required fields."
            return
        }
        
        // Get current date and time as timestamp
        let timestamp = Timestamp(date: date)
        
        // Create a dictionary with the appointment details
        let appointmentData: [String: Any] = [
            "title": title,
            "location": location,
            "date": timestamp,
            "notes": notes
        ]
        
        // Save to Firestore
        db.collection("appointments").addDocument(data: appointmentData) { error in
            if let error = error {
                print("Error adding document: \(error.localizedDescription)")
            } else {
                // Show confirmation alert
                isShowingConfirmation = true
            }
        }
    }
}

#Preview {
    AddAppointmentView()
}
