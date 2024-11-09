import SwiftUI

struct HealthView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // BMI Card Section
                    VStack {
                        HStack {
                            Text("Weight 57kg")
                            Spacer()
                            Text("Height 157cm")
                        }
                        .font(.footnote)
                        .foregroundColor(.gray)
                        
                        HStack {
                            Text("BMI")
                                .font(.largeTitle)
                                .bold()
                            Spacer()
                            Text("20.24")
                                .font(.title)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(12)
                    .shadow(color: .gray.opacity(0.4), radius: 8, x: 0, y: 4) // Shadow for "pop-up" effect

                    // Health Summary Grid Section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Today's Health Summary")
                            .font(.headline)
                        
                        HStack(spacing: 10) {
                            HealthSummaryCard(icon: "heart.fill", title: "Heart Rate", value: "78", unit: "bpm", color: Color.pink)
                            HealthSummaryCard(icon: "thermometer", title: "Body Temperature", value: "37", unit: "°C", color: Color.purple)
                        }
                        
                        HStack(spacing: 10) {
                            HealthSummaryCard(icon: "figure.walk", title: "Walking", value: "10", unit: "km", color: Color.teal)
                            HealthSummaryCard(icon: "bed.double.fill", title: "Sleep", value: "8", unit: "hrs", color: Color.blue)
                        }
                    }

                    // Share Section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Share Your Health Data with Your Doctor")
                            .font(.subheadline)
                        
                        Text("Select an appointment from the dropdown and attach your health details to share with your doctor for a more personalized consultation")
                            .font(.footnote)
                            .foregroundColor(.gray)
                        
                        HStack(spacing: 10) {
                            Button(action: {
                                // Select appointment action
                            }) {
                                HStack {
                                    Text("Select appointment")
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                }
                                .padding()
                                .frame(height: 44)
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(10)
                            }
                            
                            Button(action: {
                                // Share action
                            }) {
                                HStack {
                                    Image(systemName: "square.and.arrow.up")
                                    Text("Share")
                                }
                                .padding()
                                .frame(height: 44)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                            }
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6)) // Light background color
            }
            .navigationTitle("Health Overview") // Sets the title in the navigation bar
            .navigationBarTitleDisplayMode(.inline) // Inline display for a compact look
        }
        .background(Color(.systemGray6).edgesIgnoringSafeArea(.all)) // Safe area coverage for full-screen background
    }
}

// MARK: - Health Summary Card
struct HealthSummaryCard: View {
    var icon: String
    var title: String
    var value: String
    var unit: String
    var color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                Spacer()
            }
            Spacer()
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
            HStack(alignment: .lastTextBaseline, spacing: 2) {
                Text(value)
                    .font(.title)
                    .foregroundColor(color)
                Text(unit)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 90) // Adjusted height for flexibility
        .background(color.opacity(0.1))
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.4), radius: 8, x: 0, y: 4) // Shadow for "pop-up" effect
    }
}

// Preview
#Preview {
    HealthView()
}

