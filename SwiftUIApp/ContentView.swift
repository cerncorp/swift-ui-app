//
//  ContentView.swift
//  SwiftUIApp
//
//  Created by yoha on 25/07/2025.
//

//import SwiftUI
//
//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundColor(.accentColor)
//            Text("Hello, Hung!")
//        }
//        .padding()
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

import SwiftUI

struct ContentView: View {
    @StateObject var authVM = AuthViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if authVM.isLoggedIn {
                    MainView()
                        .environmentObject(authVM)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing).combined(with: .opacity),
                            removal: .move(edge: .leading).combined(with: .opacity)
                        ))
                } else {
                    LoginView()
                        .environmentObject(authVM)
                        .transition(.asymmetric(
                            insertion: .move(edge: .leading).combined(with: .opacity),
                            removal: .move(edge: .trailing).combined(with: .opacity)
                        ))
                }
            }
            .animation(.easeInOut(duration: 0.5), value: authVM.isLoggedIn)
        }
        .environmentObject(authVM)
        .onChange(of: authVM.isLoggedIn) { newValue in
            print("🔐 Auth state changed: isLoggedIn = \(newValue)")
        }
    }
}
