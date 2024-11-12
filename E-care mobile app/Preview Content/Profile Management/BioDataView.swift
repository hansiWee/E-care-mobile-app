import Firebase
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct UpdateProfileView: View {
    @State private var fullName = ""
    @State private var email = ""  // Email will be non-editable
    @State private var password = ""
    @State private var mobileNumber = ""
    @State private var gender = "Select your gender"
    @State private var birthDate = Date()
    @State private var errorMessage = ""
    @State private var isLoading = false
    @State private var offset: CGFloat = 0 // Offset for keyboard avoidance
    @State private var showDatePicker = false // To toggle date picker view
    @Binding var isUserLoggedIn: Bool // Binding to control the login state
    
    // This function is called when the user taps "Update"
    func updateProfile() {
        // Reset error message and start loading
        errorMessage = ""
        isLoading = true
        
        // Validate user input
        guard !fullName.isEmpty, !mobileNumber.isEmpty else {
            errorMessage = "Please fill in all fields."
            isLoading = false
            return
        }
        
        // Firebase Auth update profile (e.g., display name)
        if let user = Auth.auth().currentUser {
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = fullName // Updating the full name in Firebase Auth
            changeRequest.commitChanges { error in
                if let error = error {
                    errorMessage = "Failed to update profile: \(error.localizedDescription)"
                    isLoading = false
                    return
                }
                
                // Proceed to update additional data in Firestore
                updateUserDataInFirestore(userUID: user.uid)
            }
        }
    }
    
    // Function to update user data in Firestore
    func updateUserDataInFirestore(userUID: String) {
        let db = Firestore.firestore()
        db.collection("users").document(userUID).setData([
            "fullName": fullName,
            "email": email,
            "mobileNumber": mobileNumber,
            "gender": gender,
            "birthDate": birthDate
        ], merge: true) { error in
            isLoading = false
            if let error = error {
                errorMessage = "Failed to save user data: \(error.localizedDescription)"
            } else {
                // Success! Now you can update the `isUserLoggedIn` state or handle navigation.
                DispatchQueue.main.async {
                    isUserLoggedIn = true
                }
                print("User data updated successfully!")
            }
        }
    }
    
    var body: some View {
        Group {
            if isUserLoggedIn {
                MainView(isUserLoggedIn: .constant(false)) // Navigate to MainView when user is logged in
            } else {
                content
            }
        }
    }
    
    var content: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Update Your Account")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    // Full Name Field
                    TextField("Full Name", text: $fullName)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .autocapitalization(.words)
                        .disableAutocorrection(true)
                    
                    // Email Field (Non-editable)
                    Text(email)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .foregroundColor(.gray)
                    
                    // Mobile Number Field
                    TextField("Mobile Number", text: $mobileNumber)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .keyboardType(.phonePad)
                    
                    // Gender Picker (Menu)
                    Menu {
                        ForEach(["Male", "Female", "Other"], id: \.self) { option in
                            Button(option) {
                                gender = option
                            }
                        }
                    } label: {
                        HStack {
                            Text(gender)
                                .foregroundColor(gender == "Select your gender" ? .gray : .primary)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.horizontal)
                    }.frame(maxWidth: .infinity)

                    // Date of Birth Section
                    HStack {
                        Text("What is your date of birth?")
                            .foregroundColor(.gray)
                        Spacer()
                        Button(action: {
                            withAnimation {
                                showDatePicker.toggle()
                            }
                        }) {
                            Image(systemName: "calendar")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal)

                    // Show DatePicker modal
                    if showDatePicker {
                        DatePicker("Select Date", selection: $birthDate, in: ...Date(), displayedComponents: .date)
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity)  // Ensure full width for the date picker
                    }
                    
                    // Show error message if there is one
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding(.top, 10)
                    }
                    
                    // Show loading spinner while update is in progress
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding(.top, 10)
                    }
                    
                    Button(action: {
                        updateProfile()
                    }) {
                        Text("Update Profile")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    .padding(.top, 10)
                    
                    Spacer()
                    
                    // Continue with Apple action (if needed)
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
}

#Preview {
    UpdateProfileView(isUserLoggedIn: .constant(false))
}

