import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import ImagePicker

struct BioDataView: View {
    @State private var fullName: String = ""
    @State private var phoneNumber: String = ""
    @State private var gender: String = ""
    @State private var birthDate = Date()
    @State private var showDatePicker = false
    @State private var selectedGender = "Select your gender"
    @State private var countryCode = "+1" // Default to USA, you can add other country codes
    let genderOptions = ["Male", "Female", "Other"]
    let countryCodes = ["+1", "+44", "+91", "+61"] // Example country codes
    @State private var errorMessage = ""
    @State private var isLoading = false
    @State private var profileImage: Image? // For displaying the selected image
    @State private var selectedImageData: Data? // To hold the image data
    @State private var showImagePicker = false // Show image picker for selecting image
    
    // Function to update profile
    func updateProfile() {
        errorMessage = ""
        isLoading = true
        
        if let user = Auth.auth().currentUser {
            // First, upload the profile image to Firebase Storage if an image is selected
            if let imageData = selectedImageData {
                uploadProfileImage(imageData: imageData) { imageUrl in
                    if let imageUrl = imageUrl {
                        // Update Firestore data with image URL
                        updateUserDataInFirestore(userUID: user.uid, imageUrl: imageUrl)
                    } else {
                        // Handle error uploading image
                        errorMessage = "Failed to upload profile image."
                        isLoading = false
                    }
                }
            } else {
                // No image selected, just update text data
                updateUserDataInFirestore(userUID: user.uid, imageUrl: nil)
            }
        }
    }
    
    // Function to upload profile image to Firebase Storage
    func uploadProfileImage(imageData: Data, completion: @escaping (String?) -> Void) {
        let storage = Storage.storage()
        let storageRef = storage.reference().child("profileImages/\(UUID().uuidString).jpg")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        storageRef.putData(imageData, metadata: metadata) { metadata, error in
            if let error = error {
                print("Error uploading image: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            // Get the download URL of the uploaded image
            storageRef.downloadURL { url, error in
                if let error = error {
                    print("Error getting download URL: \(error.localizedDescription)")
                    completion(nil)
                } else {
                    completion(url?.absoluteString)
                }
            }
        }
    }
    
    // Function to update user data in Firestore
    func updateUserDataInFirestore(userUID: String, imageUrl: String?) {
        let db = Firestore.firestore()
        var data: [String: Any] = [
            "fullName": fullName,
            "mobileNumber": phoneNumber,
            "gender": gender,
            "birthDate": Timestamp(date: birthDate)
        ]
        
        // Add the image URL if available
        if let imageUrl = imageUrl {
            data["profileImageUrl"] = imageUrl
        }
        
        db.collection("users").document(userUID).setData(data, merge: true) { error in
            isLoading = false
            if let error = error {
                errorMessage = "Failed to save user data: \(error.localizedDescription)"
            } else {
                print("User data updated successfully!")
            }
        }
    }
    
    // Function to present the Image Picker
    func presentImagePicker() {
        showImagePicker = true
    }
    
    var body: some View {
        VStack(spacing: 16) {
            // Navigation title
            Text("Update Profile")
                .font(.title2)
                .bold()
                .padding(.top, 20)
            
            // Profile image and user details
            VStack(spacing: 8) {
                // Display the profile image or a placeholder image
                Button(action: presentImagePicker) {
                    if let profileImage = profileImage {
                        profileImage
                            .resizable()
                            .frame(width: 90, height: 90)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 90, height: 90)
                            .foregroundColor(.gray)
                    }
                }
                
                Text("Upload a picture")
                    .font(.caption)
                    .foregroundColor(.blue)
                    .onTapGesture {
                        presentImagePicker()
                    }
                
                // Display the full name from Firebase Auth
                if let user = Auth.auth().currentUser {
                    Text(user.displayName ?? "Your Name")
                        .font(.system(size: 22, weight: .bold))
                }
                
                Text("annSmith@gmail.com") // This email is constant, coming from Firebase
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            .padding(.bottom, 20)
            
            // Full name text field (editable)
            TextField("Full name", text: $fullName)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal)
            
            // Phone number with country code picker (editable)
            HStack {
                Picker("Country Code", selection: $countryCode) {
                    ForEach(countryCodes, id: \.self) { code in
                        Text(code)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .frame(width: 100)

                TextField("Phone number", text: $phoneNumber)
                    .keyboardType(.phonePad)
                    .padding()
                    .frame(maxWidth: .infinity)
            }
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .padding(.horizontal)
            
            // Gender Picker (editable)
            Menu {
                ForEach(genderOptions, id: \.self) { option in
                    Button(option) {
                        gender = option
                    }
                }
            } label: {
                HStack {
                    Text(gender.isEmpty ? selectedGender : gender)
                        .foregroundColor(gender.isEmpty ? .gray : .primary)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal)
            }
            
            // Date of Birth
            HStack {
                Text("What is your date of birth?")
                    .foregroundColor(.gray)
                Spacer()
                Button(action: {
                    showDatePicker.toggle()
                }) {
                    Image(systemName: "calendar")
                        .foregroundColor(.blue)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .padding(.horizontal)
            
            if showDatePicker {
                DatePicker("Date of Birth", selection: $birthDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding(.horizontal)
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
            
            // Update Profile button
            Button(action: {
                updateProfile()
            }) {
                Text("Update Profile")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            
            Spacer()
        }
        .padding()
        .onAppear {
            if let user = Auth.auth().currentUser {
                fullName = user.displayName ?? ""
                let db = Firestore.firestore()
                db.collection("users").document(user.uid).getDocument { document, error in
                    if let document = document, document.exists {
                        if let data = document.data() {
                            phoneNumber = data["mobileNumber"] as? String ?? ""
                            gender = data["gender"] as? String ?? ""
                            if let birth = data["birthDate"] as? Timestamp {
                                birthDate = birth.dateValue()
                            }
                            if let imageUrl = data["profileImageUrl"] as? String {
                                loadImageFromUrl(urlString: imageUrl)
                            }
                        }
                    }
                }
            }
        }
    }
    
    // Function to load profile image from URL
    func loadImageFromUrl(urlString: String) {
        if let url = URL(string: urlString) {
            let data = try? Data(contentsOf: url)
            if let data = data, let uiImage = UIImage(data: data) {
                profileImage = Image(uiImage: uiImage)
            }
        }
    }
}

#Preview {
    BioDataView()
}

