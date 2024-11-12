import SwiftUI
import Firebase
import FirebaseAuth
import LocalAuthentication

struct LoginView: View {
    @State private var mobileNumber = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var isLoading = false
    @State private var isLoggedIn = false  // State to control navigation to MainView
    @State private var isNavigatingToSignUp = false  // State to control navigation to SignUpView
    @State private var isAuthenticated = false
    @State private var showBiometricError = false
    var body: some View {
        Group {
            if isLoggedIn {
                MainView() // Navigate to MainView when user is logged in
            } else {
                content
            }
        }
    }
    
    var content: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Hello!")
                    .font(.title)
                    .fontWeight(.bold)

                TextField("Email", text: $mobileNumber)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .keyboardType(.phonePad)

                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)

                // Show error message if login fails
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding(.top, 10)
                }

                // Show loading spinner while logging in
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding(.top, 10)
                }

                Button(action: {
                    loginUser()
                }) {
                    Text("Log In")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }

                Text("or")
                    .foregroundColor(.gray)

               
                    // Continue with Apple action
                    SignInButton()
                    .frame(width: 250, height: 44)

                Spacer()
                // Biometric Authentication Buttons
                HStack(spacing: 30) {
                    Button(action: {
                        authenticateWithFaceID()
                    }) {
                        Image(systemName: "faceid")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 60)
                    }
                    
                }

                               Spacer()

                NavigationLink(destination: SignUpView(isUserLoggedIn: $isLoggedIn), isActive: $isNavigatingToSignUp) {
                    Button(action: {
                        isNavigatingToSignUp = true
                    }) {
                        Text("Don't have an account? Sign Up")
                            .foregroundColor(.blue)
                    }
                }
            }
            .padding()
        }
    }
    
    // Function to handle login logic
    func loginUser() {
        // Reset error message and start loading
        errorMessage = ""
        isLoading = true
        
        // Validate input
        guard !mobileNumber.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill in all fields."
            isLoading = false
            return
        }

        // Firebase authentication using email and password
        Auth.auth().signIn(withEmail: mobileNumber, password: password) { result, error in
            isLoading = false

            if let error = error {
                errorMessage = "Login failed: \(error.localizedDescription)"
                return
            }

            // Successfully logged in, handle navigation
            if result != nil {
                isLoggedIn = true  // Trigger navigation only after successful login
                print("User logged in successfully")
            }
        }
    }
    
    // Function to authenticate using FaceID
        func authenticateWithFaceID() {
            let context = LAContext()
            var error: NSError?

            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Authenticate using Face ID") { success, authenticationError in
                    DispatchQueue.main.async {
                        if success {
                            isAuthenticated = true
                            isLoggedIn = true // Navigate to MainView on successful authentication
                        } else {
                            showBiometricError = true // Show error if authentication fails
                            errorMessage = "Face ID authentication failed."
                        }
                    }
                }
            } else {
                errorMessage = "Face ID is not available on this device."
            }
        }
}

#Preview {
    LoginView()
}

