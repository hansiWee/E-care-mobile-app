//
//  E_care_mobile_appApp.swift
//  E-care mobile app
//
//  Created by COCOBSCCOMPY4231P-035 on 2024-11-08.
//

import SwiftUI
import Firebase
import PhoneNumberKit

@main
struct E_care_mobile_appApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            WelcomeView()
        }
    }
}
