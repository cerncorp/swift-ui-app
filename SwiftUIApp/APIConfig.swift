//
//  APIConfig.swift
//  SwiftUIApp
//
//  Created by yoha on 09/08/2025.
//

import Foundation

struct APIConfig {
    // Update this URL when your ngrok URL changes
    static let baseURL = "https://8807fb34bf66.ngrok-free.app"
    
    // API Endpoints
    static let loginEndpoint = "/login"
    static let registerEndpoint = "/register"
    
    // Headers
    static let contentType = "application/json"
    
    // Timeout
    static let timeoutInterval: TimeInterval = 30.0
    
    // Helper function to get full URL for endpoint
    static func getURL(for endpoint: String) -> String {
        return baseURL + endpoint
    }
    
    // Helper function to update base URL
    static func updateBaseURL(_ newURL: String) {
        // This would typically update a stored configuration
        print("🔄 API Base URL updated to: \(newURL)")
    }
}
