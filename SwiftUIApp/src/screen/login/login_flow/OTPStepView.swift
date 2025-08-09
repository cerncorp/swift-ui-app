//
//  OTPStepView.swift
//  SwiftUIApp
//
//  Created by yoha on 09/08/2025.
//

import SwiftUI

struct OTPStepView: View {
    @EnvironmentObject var loginVM: MultiStepLoginViewModel
    var body: some View {
        VStack(spacing: 20) {
            Text("Xác thực OTP")
                .font(.title)
            TextField("Mã OTP", text: $loginVM.otp)
                .textFieldStyle(.roundedBorder)
                .padding()
                .keyboardType(.numberPad)
            Button("Xác nhận") { loginVM.nextStep() }
                .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

