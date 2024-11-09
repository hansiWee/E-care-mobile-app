import SwiftUI

struct AppointmentCard: View {
    var doctorName: String
    var specialization: String
    
    @State private var doctorProfileImage: String = "new" // Replace with a variable that links to your API's profile image URL
    
    var body: some View {
        HStack {
            Image(doctorProfileImage) // Dynamically loaded image (can be URL from backend)
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 3) {
                Text(doctorName)
                    .fontWeight(.bold)
                Text(specialization)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // NavigationLink for booking
            NavigationLink(destination: AddAppointmentView()) {
                Text("Book Now")
                    .padding(8)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 3)
    }
}

// Preview
#Preview {
    NavigationView {
        AppointmentCard(doctorName: "Dr. Olivia Turner, M.D.", specialization: "Dermato-Endocrinology")
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

