//
//  AuthViewModel.swift
//  SwiftUIApp
//
//  Created by yoha on 09/08/2025.
//

import Foundation
import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var email: String = ""
    
    func login(email: String, password: String) {
        print("🔐 Attempting login with email: \(email)")
        // Giả sử login thành công
        DispatchQueue.main.async {
            self.email = email
            self.isLoggedIn = true
            print("✅ Login successful, isLoggedIn set to: \(self.isLoggedIn)")
        }
    }
    
    func register(email: String, password: String) {
        print("🔐 Attempting registration with email: \(email)")
        // Giả sử đăng ký thành công
        DispatchQueue.main.async {
            self.email = email
            self.isLoggedIn = true
            print("✅ Registration successful, isLoggedIn set to: \(self.isLoggedIn)")
        }
    }
    
    func logout() {
        print("🔐 Logging out user: \(email)")
        DispatchQueue.main.async {
            self.email = ""
            self.isLoggedIn = false
            print("✅ Logout successful, isLoggedIn set to: \(self.isLoggedIn)")
        }
    }
}
