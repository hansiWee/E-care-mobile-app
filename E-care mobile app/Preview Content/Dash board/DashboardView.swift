import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct UserProfile: Codable {
    var email: String
    var fullName: String
    var mobileNumber: String
    var profileImageUrl: String
}

struct DashboardView: View {
    
    @State private var selectedDate = "11 Wed"
    @State private var userProfile: UserProfile? // Store the fetched user profile
    @State private var isLoading = true // Indicate loading state
    
    // Sample health metrics data
    @State private var heartRate = "78 bpm"
    @State private var sleepHours = "8 hrs"
    @State private var walkingDistance = "10 km"

    var body: some View {
        VStack(spacing: 0) {
            ScrollView { // Wrap main content in ScrollView
                VStack(spacing: 20) { // Increased spacing to prevent overlap
                    // Top Greeting and User Info
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Hi, Welcome Back")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            if let userProfile = userProfile {
                                Text(userProfile.fullName) // Display fetched full name
                                    .font(.headline)
                            } else {
                                Text("Loading...") // Placeholder while loading
                                    .font(.headline)
                            }
                        }
                        Spacer()
                        
                        if let userProfile = userProfile {
                            // Use a static profile image
                            AsyncImage(url: URL(string: "defaultProfileImageURL")) { image in
                                image.resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            } placeholder: {
                                ProgressView() // Loading indicator while the image is loading
                            }
                        } else {
                            // Placeholder if no profile data is available
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                .foregroundColor(.gray)
                        }

                    }
                    .padding(.horizontal)

                    // Promo Banner
                    Image("promo-banner") // Replace with actual image asset
                        .resizable()
                        .scaledToFill()
                        .frame(height: 150)
                        .clipped()
                        .padding(.horizontal)
                    
                    // Calendar Section
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(9..<15) { day in
                                DateButton(day: day, dayText: "MON") // Update day names as needed
                            }
                        }
                        .padding()
                    }
                    
                    HStack(spacing: 15) { // Horizontal stack with spacing between buttons
                        Button(action: {
                            print("AI Assistance Button Pressed")
                        }) {
                            VStack {
                                Image(systemName: "brain.head.profile") // Icon for AI Assistance
                                    .font(.title) // Icon size
                                Text("AI Doctor Help")
                                    .font(.system(size: 15)) // Set font size to 15
                                    .fontWeight(.semibold)
                            }
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 170, height: 100) // Fixed width and height for equal sizing
                            .background(Color.blue)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        }
                        
                        Button(action: {
                            print("My Appointment")
                        }) {
                            VStack {
                                Image(systemName: "calendar") // Icon for My Appointments
                                    .font(.title) // Icon size
                                Text("My Appointments")
                                    .font(.system(size: 15)) // Set font size to 15
                                    .fontWeight(.semibold)
                            }
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 170, height: 100) // Fixed width and height for equal sizing
                            .background(Color.blue)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)

                    
                    // Activity Cards Section
                    VStack(alignment: .leading) {
                        Text("Digital Health Insight")
                            .font(.headline)
                            .padding(.horizontal)
                        Spacer()
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ActivityCard()
                                ActivityCard()
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.bottom, 20) // Added bottom padding to separate the sections

                    // Appointments Section
                    VStack(alignment: .leading) {
                        Text("My Appointments")
                            .font(.headline)
                            .padding(.horizontal)

                        ScrollView {
                            VStack(spacing: 15) {
                                ForEach(0..<3) { index in
                                    AppointmentCard(doctorName: "Dr. Olivia Turner, M.D.", specialization: "Dermato-Endocrinology")
                                        .padding() // Add padding around the card
                                        .background(Color.white) // Ensure background is white to show shadow
                                        .cornerRadius(10)
                                        .shadow(color: .gray, radius: 5, x: 0, y: 2) // Apply shadow
                                }
                            }
                        }
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            // Fetch user profile data when the view appears
            fetchUserProfile()
        }
    }
    
    // Fetch user profile from Firebase Firestore
    func fetchUserProfile() {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("No user logged in.")
            return
        }

        let db = Firestore.firestore()

        db.collection("users").document(userId).getDocument { document, error in
            if let document = document, document.exists {
                // Fetch user data from Firestore
                let data = document.data()
                let email = data?["email"] as? String ?? ""
                let fullName = data?["fullName"] as? String ?? ""
                let mobileNumber = data?["mobileNumber"] as? String ?? ""

                DispatchQueue.main.async {
                    // Use a static image for the profile
                    self.userProfile = UserProfile(email: email, fullName: fullName, mobileNumber: mobileNumber, profileImageUrl: "defaultProfileImageURL")
                    self.isLoading = false
                }
            } else {
                print("Document does not exist or error: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }

}


#Preview {
    DashboardView()
}

