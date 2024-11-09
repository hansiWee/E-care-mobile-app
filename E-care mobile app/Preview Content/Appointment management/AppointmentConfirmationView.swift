import SwiftUI

struct AppointmentConfirmationView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Doctor Profile Card
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Image(systemName: "person.circle.fill") // Placeholder for doctor image
                        .resizable()
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                    VStack(alignment: .leading) {
                        Text("Dr. Alexander Bennett, Ph.D.")
                            .font(.headline)
                        Text("Dermato-Genetics")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        HStack(spacing: 10) {
                            Label("5", systemImage: "star.fill")
                                .font(.caption)
                            Label("60", systemImage: "person.fill")
                                .font(.caption)
                            Image(systemName: "questionmark.circle")
                            Image(systemName: "heart")
                        }
                    }
                    Spacer()
                }
            }
            .padding()
            .background(Color.blue.opacity(0.1))
            .cornerRadius(15)

            // Appointment Information
            Text("Appointment one")
                .font(.headline)
            
            HStack {
                Text("Month 24, Year")
                    .padding(10)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                Text("WED, 10:00 AM")
                    .foregroundColor(.gray)
                Spacer()
                Image(systemName: "checkmark.circle.fill")
                Image(systemName: "xmark.circle.fill")
            }
            
            Divider()
            
            // Patient Details
            VStack(alignment: .leading, spacing: 5) {
                Text("Booking For")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("Another Person")
                
                Text("Full Name")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("Jane Doe")
                
                Text("Age")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("30")
                
                Text("Gender")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("Female")
            }

            Divider()

            // Problem Description
            VStack(alignment: .leading, spacing: 5) {
                Text("Problem")
                    .font(.headline)
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
                    .foregroundColor(.gray)
            }
            
            Spacer()

            // Edit and Confirm Buttons
            HStack {
                Button(action: {
                    // Edit action
                }) {
                    Text("Edit")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.2))
                        .foregroundColor(.blue)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    // Confirm action
                }) {
                    Text("Confirm")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding(.vertical)
        }
        .padding()
    }
}

struct AppointmentConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentConfirmationView()
    }
}

