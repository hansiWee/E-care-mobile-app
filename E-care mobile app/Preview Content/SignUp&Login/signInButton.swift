import SwiftUI
import AuthenticationServices
import FirebaseAuth
import FirebaseFirestore // Ensure Firestore is imported

struct SignInButton: UIViewRepresentable {
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        let button = ASAuthorizationAppleIDButton()
        button.addTarget(context.coordinator, action: #selector(Coordinator.didTapSignIn), for: .touchUpInside)
        return button
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
        // No need to update the button for now
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject {
        @objc func didTapSignIn() {
            let request = ASAuthorizationAppleIDProvider().createRequest()
            request.requestedScopes = [.fullName, .email]
            
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        }
    }
}

// MARK: - ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding

extension SignInButton.Coordinator: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            // Create a Firebase credential with the Apple ID token
            guard let appleIDToken = appleIDCredential.identityToken,
                  let tokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Apple ID token is missing.")
                return
            }
            
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: tokenString, rawNonce: "")
            
            // Sign in to Firebase with the Apple credential
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error = error {
                    print("Firebase sign-in failed: \(error.localizedDescription)")
                    return
                }
                
                // Successfully signed in with Firebase
                if let user = authResult?.user {
                    // You can use user information or update user profile if needed
                    print("User signed in with Apple: \(user.displayName ?? "No Name")")
                    
                    // Handle nil values by providing default values (e.g., empty strings)
                    let fullNameString = fullName?.givenName ?? "No Name" // Default to "No Name" if nil
                    let emailString = email ?? "No Email" // Default to "No Email" if nil
                    
                    // Save additional information like fullName, email in Firestore
                    let db = Firestore.firestore() // Now this should work
                    db.collection("users").document(user.uid).setData([
                        "fullName": fullNameString,  // Default value handling here
                        "email": emailString         // Default value handling here
                    ]) { error in
                        if let error = error {
                            print("Error saving user data: \(error.localizedDescription)")
                        } else {
                            print("User data saved successfully.")
                        }
                    }
                }
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Sign in with Apple failed: \(error.localizedDescription)")
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        UIApplication.shared.windows.first { $0.isKeyWindow }!
    }
}

#Preview {
    SignInButton()
}

