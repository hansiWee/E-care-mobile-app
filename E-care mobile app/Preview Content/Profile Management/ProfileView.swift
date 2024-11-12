import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct ProfileView: View {
    @Binding var isUserLoggedIn: Bool // Add this to accept the binding
    
    @State private var isFaceIDEnabled = false
    @State private var userName: String = "User Name" // Default name if not available

    var body: some View {
        List {
            // Profile Image and Name
            VStack(spacing: 8) {
                Image("profileImage") // Replace with the actual image name in Assets
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 90, height: 90)
                    .clipShape(Circle())

                Text(userName) // Display the actual user's name
                    .font(.system(size: 24, weight: .bold))
            }
            .padding(.top, 20)
            .onAppear {
                fetchUserName()
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            // List of Options
            Section {
                NavigationLink(destination: UpdateProfileView(isUserLoggedIn: $isUserLoggedIn)) {
                    ProfileRow(icon: "person.circle", title: "My Account", subtitle: "Make changes to your account")
                        .foregroundColor(.primary)
                }
                NavigationLink(destination: BioDataView()) {
                    ProfileRow(icon: "person.2.circle", title: "Saved Beneficiary", subtitle: "Manage your saved account")
                        .foregroundColor(.primary)
                }
                Toggle(isOn: $isFaceIDEnabled) {
                    ProfileRow(icon: "faceid", title: "Face ID / Touch ID", subtitle: "Manage your device security")
                }
                NavigationLink(destination: Text("Log out")) {
                    ProfileRow(icon: "arrowshape.turn.up.left", title: "Log out", subtitle: "Further secure your account for safety")
                        .foregroundColor(.primary)
                }
            }

            Section {
                NavigationLink(destination: LoginView()) {
                    ProfileRow(icon: "questionmark.circle", title: "Help & Support")
                        .foregroundColor(.primary)
                }
                NavigationLink(destination: Text("About App")) {
                    ProfileRow(icon: "info.circle", title: "About App")
                        .foregroundColor(.primary)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Profile")
    }

    // Function to fetch the current user's name
    private func fetchUserName() {
        if let user = Auth.auth().currentUser {
            userName = user.displayName ?? "User Name" // Use displayName if available, otherwise default
        }
    }
}

// Custom Row View
struct ProfileRow: View {
    var icon: String
    var title: String
    var subtitle: String = ""

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 24, height: 24)

            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
                if !subtitle.isEmpty {
                    Text(subtitle)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
            }
            .padding(.vertical, 10) // Add vertical padding to increase the row height
        }
        .frame(minHeight: 50) // Set a minimum height for the row
    }
}

#Preview {
    NavigationStack {  // Changed to NavigationStack as it is the preferred approach
        ProfileView(isUserLoggedIn: .constant(true)) // Passing binding correctly
    }
}

