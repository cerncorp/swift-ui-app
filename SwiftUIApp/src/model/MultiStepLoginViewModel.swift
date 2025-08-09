//
//  MultiStepLoginViewModel.swift
//  SwiftUIApp
//
//  Created by yoha on 09/08/2025.
//

import SwiftUI

enum LoginStep: Int, CaseIterable {
    case email = 0
    case password
    case otp
    case done
}

class MultiStepLoginViewModel: ObservableObject {
    @Published var step: LoginStep = .email
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var otp: String = ""
    @Published var isLoggedIn = false
    
    func nextStep() {
        withAnimation(.easeInOut) {
            switch step {
            case .email:
                if !email.isEmpty { step = .password }
            case .password:
                if !password.isEmpty { step = .otp }
            case .otp:
                if otp == "123456" { // Giả lập check OTP
                    isLoggedIn = true
                    step = .done
                }
            case .done:
                break
            }
        }
    }
    
    func reset() {
        withAnimation(.easeInOut) {
            step = .email
            email = ""
            password = ""
            otp = ""
            isLoggedIn = false
        }
    }
}
