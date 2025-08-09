//
//  PasswordStepView.swift
//  SwiftUIApp
//
//  Created by yoha on 09/08/2025.
//


import SwiftUI

struct PasswordStepView: View {
    @EnvironmentObject var loginVM: MultiStepLoginViewModel
    var body: some View {
        VStack(spacing: 20) {
            Text("Nhập Mật Khẩu")
                .font(.title)
            SecureField("Password", text: $loginVM.password)
                .textFieldStyle(.roundedBorder)
                .padding()
            Button("Tiếp tục") { loginVM.nextStep() }
                .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
