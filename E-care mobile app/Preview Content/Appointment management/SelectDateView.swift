import SwiftUI

struct SelectDateView: View {
    @State private var selectedDate: Int = 24
    @State private var selectedTime: String = "10:00 AM"

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Doctor Profile Card
            VStack(alignment: .center, spacing: 15) {
                Image(systemName: "person.circle.fill") // Placeholder for profile image
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                
                HStack {
                    Text("15 years experience")
                        .font(.caption)
                        .padding(5)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(10)
                    Spacer()
                    Text("Focus: Skin conditions, hormonal issues")
                        .font(.caption)
                        .padding(5)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(10)
                }
                
                Text("Dr. Alexander Bennett, Ph.D.")
                    .font(.headline)
                Text("Dermato-Genetics")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                HStack(spacing: 10) {
                    Label("5", systemImage: "star.fill")
                        .font(.caption)
                    Label("40", systemImage: "person.fill")
                        .font(.caption)
                    Label("Mon-Sat / 9:00AM - 5:00PM", systemImage: "clock.fill")
                        .font(.caption)
                }

                Button(action: {
                    // Schedule action
                }) {
                    Text("Schedule")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            .background(Color.blue.opacity(0.1))
            .cornerRadius(15)

            // Date Selection
            Text("Month")
                .font(.headline)
            HStack(spacing: 10) {
                ForEach(22...27, id: \.self) { day in
                    Button(action: {
                        selectedDate = day
                    }) {
                        Text("\(day)")
                            .frame(width: 40, height: 40)
                            .background(selectedDate == day ? Color.blue : Color.gray.opacity(0.2))
                            .foregroundColor(selectedDate == day ? .white : .black)
                            .cornerRadius(10)
                    }
                }
            }

            // Available Time Slots
            Text("Available Time")
                .font(.headline)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                ForEach(["9:00 AM", "9:30 AM", "10:00 AM", "10:30 AM", "11:00 AM", "11:30 AM", "12:00 PM", "12:30 PM", "1:00 PM", "1:30 PM", "2:00 PM", "2:30 PM", "3:00 PM", "3:30 PM", "4:00 PM"], id: \.self) { time in
                    Button(action: {
                        selectedTime = time
                    }) {
                        Text(time)
                            .padding(10)
                            .background(selectedTime == time ? Color.blue : Color.gray.opacity(0.2))
                            .foregroundColor(selectedTime == time ? .white : .black)
                            .cornerRadius(10)
                    }
                }
            }

            // Continue Button
            Button(action: {
                // Continue action
            }) {
                Text("Continue")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.vertical)
        }
        .padding()
    }
}

#Preview {
    SelectDateView()
}

