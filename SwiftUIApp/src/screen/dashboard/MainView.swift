//
//  MainView.swift
//  SwiftUIApp
//
//  Created by yoha on 09/08/2025.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.green, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Welcome, \(authVM.email)")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.top, 50)
                
                Spacer()
                
                Button(action: {
                    authVM.logout()
                }) {
                    Text("Logout")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.horizontal, 40)
                
                Spacer()
            }
        }
    }
}
