import SwiftUI

struct SimpleFormView: View {
    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var isNavigating = false // State to control navigation
    
    var body: some View {
        NavigationStack { // Use NavigationStack for iOS 16+
            VStack(spacing: 20) {
                Text("Simple Form")
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
                
                // NavigationLink triggered when isNavigating is true
                NavigationLink(destination: DashboardView(), isActive: $isNavigating) {
                    Button(action: {
                        isNavigating = true // Trigger navigation when button is tapped
                    }) {
                        Text("Submit")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    .padding(.top, 10)
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

struct SimpleFormView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleFormView()
    }
}

