//
//  ProgressBar.swift
//  SwiftUIApp
//
//  Created by yoha on 09/08/2025.
//
import SwiftUI

struct ProgressBar: View {
    var currentStep: Int
    var totalSteps: Int
    
    var body: some View {
        VStack {
            Text("Bước \(currentStep) / \(totalSteps)")
                .font(.subheadline)
                .padding(.bottom, 4)
            
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .frame(height: 8)
                        .foregroundColor(.gray.opacity(0.3))
                    Capsule()
                        .frame(width: geo.size.width * CGFloat(currentStep) / CGFloat(totalSteps),
                               height: 8)
                        .foregroundColor(.blue)
                        .animation(.easeInOut, value: currentStep)
                }
            }
            .frame(height: 8)
        }
        .padding()
    }
}
