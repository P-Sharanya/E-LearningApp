//
//  CourseDetailsEntity.swift
//  Learning
//
//  Created by vasantha_m on 24/04/26.
//

//enum LoadingStates {
//    case idle
//    case loading
//    case loaded
//    case error
//}
import SwiftUI

struct CourseStatView: View {

    let icon: String
    let value: String
    let title: String

    var body: some View {

        VStack(spacing: 8) {

            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)
                .frame(width: 50, height: 50)

            Text(value)
                .font(.headline)
                .foregroundColor(.white)

            Text(title)
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
        }
        .frame(maxWidth: .infinity,minHeight: 100)
        .padding()
        .background(.white.opacity(0.12))
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(.white.opacity(0.15), lineWidth: 1)
        )
    }
}

struct LearnRow: View {

    let text: String

    var body: some View {

        HStack(alignment: .top, spacing: 12) {

            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.green)
                .frame(width: 20)

            Text(text)
                .foregroundColor(.white)
                .font(.subheadline)
                .fixedSize(horizontal: false, vertical: true)

            Spacer(minLength: 0)
        }
    }
}
