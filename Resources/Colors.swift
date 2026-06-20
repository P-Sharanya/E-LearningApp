//
//  Colors.swift
//  Learning
//
//  Created by vasantha_m on 25/04/26.
//

import SwiftUI

extension Color {

    static let appPrimary = Color.blue
    static let appSecondary = Color.purple
    static let cardBackground = Color.white.opacity(0.15)
    static let appBackground = Color(red: 0.12, green: 0.12, blue: 0.18)
    static let appForeground = LinearGradient(colors: [.blue, .purple],
                                              startPoint: .topLeading,
                                              endPoint: .bottomTrailing)
}

/*
 4f46e5 - light purple
 06b6d4 - Cyan
 22c55e - lightish green
 f43f5e - light red
 */
