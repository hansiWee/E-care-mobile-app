import Firebase
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SignUpView: View {
    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var mobileNumber = ""
    @State private var errorMessage = ""
    @State private var isLoading = false
    @State private var offset: CGFloat = 0 // Offset for keyboard avoidance
    @Binding var isUserLoggedIn: Bool // Binding to control the login state
    
    var body: some View {
        Group {
            if isUserLoggedIn {
                MainView() // Navigate to MainView when user is logged in
            } else {
                content
            }
        }
    }
    
    var content: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Create New Account")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    TextField("Full Name", text: $fullName)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .autocapitalization(.words)
                        .disableAutocorrection(true)
                    
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                    
                    TextField("Mobile Number", text: $mobileNumber)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .keyboardType(.phonePad)
                    
                    Toggle("I agree to Terms of Use and Privacy Policy", isOn: .constant(false))
                        .padding(.top, 10)
                    
                    // Show error message if there is one
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding(.top, 10)
                    }
                    
                    // Show loading spinner while sign-up is in progress
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding(.top, 10)
                    }
                    
                    Button(action: {
                        signUp()
                    }) {
                        Text("Sign Up")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    .padding(.top, 10)
                    
                    Spacer()
                    
                    // Continue with Apple action
                    SignInButton()
                    .frame(width: 250, height: 44)
                }
                .padding()
                .offset(y: offset) // Apply the offset for keyboard avoidance
                .onTapGesture {
                    // Dismiss the keyboard when tapping outside the text fields
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                .onAppear {
                    // Add observers to adjust offset when keyboard appears and disappears
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                            withAnimation {
                                self.offset = -keyboardFrame.height / 3 // Adjust as needed
                            }
                        }
                    }
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                        withAnimation {
                            self.offset = 0
                        }
                    }
                }
                .onDisappear {
                    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
                    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
                }
                
            }
        }
    }
    
    // Function for handling Firebase sign-up
    func signUp() {
        // Reset error message and start loading
        errorMessage = ""
        isLoading = true
        
        // Validate user input
        guard !fullName.isEmpty, !email.isEmpty, !password.isEmpty, !mobileNumber.isEmpty else {
            errorMessage = "Please fill in all fields."
            isLoading = false
            return
        }
        
        // Check if password meets minimum criteria (e.g., at least 6 characters for Firebase)
        guard password.count >= 6 else {
            errorMessage = "Password must be at least 6 characters."
            isLoading = false
            return
        }
        
        // Firebase Auth create user
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            // Stop loading once Firebase completes the request
            isLoading = false
            
            if let error = error {
                // Show error message
                errorMessage = "Failed to create account: \(error.localizedDescription)"
                return
            }
            
            // Successfully created account, now update profile information
            if let authResult = authResult {
                let user = authResult.user
                
                // Set display name and other custom user fields in Firebase
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = fullName
                changeRequest.commitChanges { error in
                    if let error = error {
                        errorMessage = "Failed to set user profile: \(error.localizedDescription)"
                        return
                    }
                    
                    // Optionally, save additional user data in Firestore
                    let db = Firestore.firestore()
                    db.collection("users").document(user.uid).setData([
                        "fullName": fullName,
                        "email": email,
                        "mobileNumber": mobileNumber
                    ]) { error in
                        if let error = error {
                            errorMessage = "Failed to save user data: \(error.localizedDescription)"
                        } else {
                            // Set isUserLoggedIn to true to persist login status
                            DispatchQueue.main.async {
                                isUserLoggedIn = true
                            }
                            print("User signed up and data saved successfully!")
                        }
                    }
                }
            }
        }
    }
}

