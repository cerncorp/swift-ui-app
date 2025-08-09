//
//  LoginView.swift
//  SwiftUIApp
//
//  Created by yoha on 09/08/2025.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Welcome Back")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.bottom, 10)
                
                Text("Login to your account")
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.bottom, 30)
                
                VStack(spacing: 16) {
                    HStack {
                        Image(systemName: "envelope")
                            .foregroundColor(.gray)
                        TextField("Email", text: $email)
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
                            .textContentType(.password)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    Button(action: {
                        authVM.login(email: email, password: password)
                    }) {
                        HStack {
                            if authVM.isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .scaleEffect(0.8)
                                Text("Logging in...")
                                    .foregroundColor(.white)
                            } else {
                                Text("Login")
                                    .foregroundColor(.white)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(authVM.isLoading ? Color.gray : Color.orange)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                    .disabled(email.isEmpty || password.isEmpty || authVM.isLoading)
                    
                    NavigationLink("Don't have an account? Register", destination: RegisterView()
                        .environmentObject(authVM)
                    )
                        .foregroundColor(.white)
                        .padding(.top, 10)
                }
                .padding()
                .background(Color.white.opacity(0.2))
                .cornerRadius(20)
                .shadow(radius: 10)
                .padding(.horizontal, 20)
                
                Spacer()
            }
        }
        .alert("Login Error", isPresented: $authVM.showError) {
            Button("OK") {
                authVM.showError = false
            }
        } message: {
            Text(authVM.errorMessage)
        }
    }
}
