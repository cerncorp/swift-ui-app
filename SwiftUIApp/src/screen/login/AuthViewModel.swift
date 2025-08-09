//
//  AuthViewModel.swift
//  SwiftUIApp
//
//  Created by yoha on 09/08/2025.
//

import Foundation
import SwiftUI

// API Response Models
struct LoginRequest: Codable {
    let username: String
    let password: String
}

struct LoginResponse: Codable {
    let success: Bool
    let message: String?
    let token: String?
    let user: UserData?
}

struct UserData: Codable {
    let id: String?
    let email: String?
    let username: String?
}

class AuthViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var email: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false
    
    private let baseURL = APIConfig.baseURL
    
    func login(email: String, password: String) {
        print("🔐 Attempting login with email: \(email)")
        
        // Reset error state
        errorMessage = ""
        showError = false
        isLoading = true
        
        // Prepare request data
        let loginData = LoginRequest(username: email, password: password)
        
        guard let url = URL(string: APIConfig.getURL(for: APIConfig.loginEndpoint)) else {
            handleError("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(APIConfig.contentType, forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = APIConfig.timeoutInterval
        
        do {
            request.httpBody = try JSONEncoder().encode(loginData)
        } catch {
            handleError("Failed to encode request data")
            return
        }
        
        // Make API request
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    self?.handleError("Network error: \(error.localizedDescription)")
                    return
                }
                
                guard let data = data else {
                    self?.handleError("No data received")
                    return
                }
                
                // Print response for debugging
                if let responseString = String(data: data, encoding: .utf8) {
                    print("📡 API Response: \(responseString)")
                }
                
                do {
                    let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                    
                    if loginResponse.success {
                        // Login successful
                        self?.email = email
                        self?.isLoggedIn = true
                        print("✅ Login successful, isLoggedIn set to: \(self?.isLoggedIn ?? false)")
                    } else {
                        // Login failed
                        let errorMsg = loginResponse.message ?? "Login failed"
                        self?.handleError(errorMsg)
                    }
                } catch {
                    // Try to parse as simple response
                    if let responseString = String(data: data, encoding: .utf8) {
//                        if responseString.contains("success") && responseString.contains("true") {
//                            // Assume success if response contains success indicators
//                            self?.email = email
//                            self?.isLoggedIn = true
//                            print("✅ Login successful (simple response), isLoggedIn set to: \(self?.isLoggedIn ?? false)")
//                        } else {
//                            self?.handleError("Invalid response format")
//                        }
                        self?.handleError("Invalid response format: \(responseString.prefix(128))")
                    } else {
                        self?.handleError("Failed to parse response")
                    }
                }
            }
        }.resume()
    }
    
    func register(email: String, password: String) {
        print("🔐 Attempting registration with email: \(email)")
        
        // Reset error state
        errorMessage = ""
        showError = false
        isLoading = true
        
        // Prepare request data
        let registerData = LoginRequest(username: email, password: password)
        
        guard let url = URL(string: APIConfig.getURL(for: APIConfig.registerEndpoint)) else {
            handleError("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(APIConfig.contentType, forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = APIConfig.timeoutInterval
        
        do {
            request.httpBody = try JSONEncoder().encode(registerData)
        } catch {
            handleError("Failed to encode request data")
            return
        }
        
        // Make API request
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    self?.handleError("Network error: \(error.localizedDescription)")
                    return
                }
                
                guard let data = data else {
                    self?.handleError("No data received")
                    return
                }
                
                // Print response for debugging
                if let responseString = String(data: data, encoding: .utf8) {
                    print("📡 Registration Response: \(responseString)")
                }
                
                do {
                    let registerResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                    
                    if registerResponse.success {
                        // Registration successful
                        self?.email = email
                        self?.isLoggedIn = true
                        print("✅ Registration successful, isLoggedIn set to: \(self?.isLoggedIn ?? false)")
                    } else {
                        // Registration failed
                        let errorMsg = registerResponse.message ?? "Registration failed"
                        self?.handleError(errorMsg)
                    }
                } catch {
                    // Try to parse as simple response
                    if let responseString = String(data: data, encoding: .utf8) {
                        if responseString.contains("success") || responseString.contains("true") {
                            // Assume success if response contains success indicators
                            self?.email = email
                            self?.isLoggedIn = true
                            print("✅ Registration successful (simple response), isLoggedIn set to: \(self?.isLoggedIn ?? false)")
                        } else {
                            self?.handleError("Invalid response format")
                        }
                    } else {
                        self?.handleError("Failed to parse response")
                    }
                }
            }
        }.resume()
    }
    
    func logout() {
        print("🔐 Logging out user: \(email)")
        DispatchQueue.main.async {
            self.email = ""
            self.isLoggedIn = false
            self.errorMessage = ""
            self.showError = false
            print("✅ Logout successful, isLoggedIn set to: \(self.isLoggedIn)")
        }
    }
    
    private func handleError(_ message: String) {
        DispatchQueue.main.async {
            self.errorMessage = message
            self.showError = true
            print("❌ Error: \(message)")
        }
    }
    
    // Update base URL (for when the URL changes)
    func updateBaseURL(_ newURL: String) {
        // You can call this method to update the base URL when it changes
        print("🔄 Updating base URL to: \(newURL)")
    }
}
