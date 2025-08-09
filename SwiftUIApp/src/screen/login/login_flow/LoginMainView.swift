//
//  LoginMainView.swift
//  SwiftUIApp
//
//  Created by yoha on 09/08/2025.
//

import SwiftUI

struct LoginMainView: View {
    @EnvironmentObject var loginVM: MultiStepLoginViewModel
    var body: some View {
        VStack(spacing: 20) {
            Text("🎉 Đăng nhập thành công!")
                .font(.largeTitle)
            Button("Đăng xuất") { loginVM.reset() }
                .buttonStyle(.bordered)
        }
    }
}
