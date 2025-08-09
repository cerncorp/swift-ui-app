//
//  EmailStepView.swift
//  SwiftUIApp
//
//  Created by yoha on 09/08/2025.
//


import SwiftUI

struct EmailStepView: View {
    @EnvironmentObject var loginVM: MultiStepLoginViewModel
    var body: some View {
        VStack(spacing: 20) {
            Text("Nhập Email")
                .font(.title)
            TextField("Email", text: $loginVM.email)
                .textFieldStyle(.roundedBorder)
                .padding()
            Button("Tiếp tục") { loginVM.nextStep() }
                .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
