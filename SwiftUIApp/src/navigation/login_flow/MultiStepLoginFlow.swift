//
//  MultiStepLoginFlow.swift
//  SwiftUIApp
//
//  Created by yoha on 09/08/2025.
//
import SwiftUI

struct MultiStepLoginFlow: View {
    @EnvironmentObject var loginVM: MultiStepLoginViewModel
    
    var body: some View {
        VStack {
            if loginVM.step != .done {
                ProgressBar(
                    currentStep: loginVM.step.rawValue + 1,
                    totalSteps: LoginStep.allCases.count - 1
                )
            }
            
            ZStack {
                switch loginVM.step {
                case .email:
                    EmailStepView()
                        .transition(.move(edge: .trailing))
                case .password:
                    PasswordStepView()
                        .transition(.move(edge: .trailing))
                case .otp:
                    OTPStepView()
                        .transition(.move(edge: .trailing))
                case .done:
                    LoginMainView()
                        .transition(.move(edge: .trailing))
                }
            }
            .animation(.easeInOut, value: loginVM.step)
        }
    }
}
