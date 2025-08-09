//
//  RegisterView.swift
//  SwiftUIApp
//
//  Created by yoha on 09/08/2025.
//
import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showError = false
    @State private var errorMessage = ""
    
    private var isFormValid: Bool {
        !email.isEmpty && !password.isEmpty && !confirmPassword.isEmpty && password == confirmPassword
    }
    
    private var passwordMatch: Bool {
        password == confirmPassword
    }
    
    private func validateForm() -> Bool {
        if email.isEmpty {
            errorMessage = "Email is required"
            showError = true
            return false
        }
        
        if !email.contains("@") {
            errorMessage = "Please enter a valid email address"
            showError = true
            return false
        }
        
        if password.isEmpty {
            errorMessage = "Password is required"
            showError = true
            return false
        }
        
        if password.count < 6 {
            errorMessage = "Password must be at least 6 characters"
            showError = true
            return false
        }
        
        if confirmPassword.isEmpty {
            errorMessage = "Please confirm your password"
            showError = true
            return false
        }
        
        if password != confirmPassword {
            errorMessage = "Passwords do not match"
            showError = true
            return false
        }
        
        return true
    }
    
    private func handleRegister() {
        print("🔐 Register button tapped")
        if validateForm() {
            print("✅ Form validation passed, calling register...")
            authVM.register(email: email, password: password)
            print("📱 Register function called, waiting for state change...")
            
            // Dismiss the RegisterView after successful registration
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                dismiss()
            }
        } else {
            print("❌ Form validation failed: \(errorMessage)")
        }
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.purple, .pink], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Create Account")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.bottom, 10)
                
                VStack(spacing: 16) {
                    HStack {
                        Image(systemName: "envelope")
                            .foregroundColor(.gray)
                        TextField("Email", text: $email)
                            .colorMultiply(.black)
                            .keyboardType(.emailAddress)
                            .textContentType(.emailAddress)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    HStack {
                        Image(systemName: "lock")
                            .foregroundColor(.gray)
                        SecureField("Password", text: $password)
                            .colorMultiply(.black)
                            .textContentType(.newPassword)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundColor(.gray)
                        SecureField("Confirm Password", text: $confirmPassword)
                            .colorMultiply(.black)
                            .textContentType(.newPassword)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    // Password match indicator
                    if !confirmPassword.isEmpty {
                        HStack {
                            Image(systemName: passwordMatch ? "checkmark.circle.fill" : "xmark.circle.fill")
                                .foregroundColor(passwordMatch ? .green : .red)
                            Text(passwordMatch ? "Passwords match" : "Passwords do not match")
                                .foregroundColor(passwordMatch ? .green : .red)
                                .font(.caption)
                        }
                        .padding(.horizontal)
                    }
                    
                    Button(action: handleRegister) {
                        Text("Sign Up")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(isFormValid ? Color.green : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .disabled(!isFormValid)
                }
                .padding()
                .background(Color.white.opacity(0.2))
                .cornerRadius(20)
                .shadow(radius: 10)
                .padding(.horizontal, 20)
                
                Spacer()
            }
        }
        .alert("Registration Error", isPresented: $showError) {
            Button("OK") {
                showError = false
            }
        } message: {
            Text(errorMessage)
        }
        .onChange(of: authVM.isLoggedIn) { newValue in
            print("🔄 RegisterView detected auth state change: isLoggedIn = \(newValue)")
            if newValue {
                // Dismiss the view when login state changes to true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    dismiss()
                }
            }
        }
    }
}
