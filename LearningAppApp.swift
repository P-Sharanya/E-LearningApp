//
//  AppDelegate.swift
//  App
//
//  Created by vasantha_m on 05/05/26.
//

import SwiftUI

struct ModernButtonStyle: ViewModifier {
    let gradientColors: [Color]

    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: gradientColors),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(
                            Color.white.opacity(0.2),
                            lineWidth: 1
                        )
                )
            )
            .foregroundColor(.white)
            .cornerRadius(12)
            .shadow(
                color: Color.black.opacity(0.25),
                radius: 10,
                x: 0,
                y: 6
            )
    }
}

struct ActionButtons: View {

    var body: some View {

        HStack(spacing: 12) {

            Button(action: {}) {

                Label(
                    "Edit Profile",
                    systemImage: "pencil"
                )
                .modifier(
                    ModernButtonStyle(
                        gradientColors: [
                            .blue,
                            .purple
                        ]
                    )
                )
            }

            Button(action: {}) {

                Label(
                    "Share",
                    systemImage: "square.and.arrow.up"
                )
                .modifier(
                    ModernButtonStyle(
                        gradientColors: [
                            .purple,
                            .pink
                        ]
                    )
                )
            }
        }
        .padding(.horizontal)
        .padding(.bottom)
    }
}
struct ActivityRow: View {
    let icon: String
    let title: String
    let time: String
    let color: Color

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .padding(8)
                .background(
                    Circle()
                        .fill(color.opacity(0.2))
                )

            VStack(alignment: .leading) {
                Text(title)
                    .fontWeight(.medium)

                Text(time)
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white.opacity(0.8))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

struct ProfileHeader: View {
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(
                    LinearGradient(
                        colors: [
                            .blue.opacity(0.7),
                            .purple.opacity(0.7)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(height: 200)

            VStack {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.white)
                    .background(
                        Circle()
                            .fill(.ultraThinMaterial)
                            .frame(width: 90, height: 90)
                    )
                    .padding(.top, 40)

                Text("Deva")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                Text("Subscribe")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
        }
    }
}
struct StatView: View {
    let icon: String
    let number: String
    let title: String

    var body: some View {
        VStack {
            Image(systemName: icon)
            Text(number)
                .font(.title2)
                .fontWeight(.bold)

            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}
