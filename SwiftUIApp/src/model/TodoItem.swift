//
//  TodoItem.swift
//  SwiftUIApp
//
//  Created by yoha on 25/07/2025.
//

import Foundation

struct TodoItem: Identifiable {
    let id = UUID()
    var title: String
    var isDone: Bool = false
}
