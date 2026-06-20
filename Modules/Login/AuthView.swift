//
//  SwiftUIView.swift
//  App
//
//  Created by vasantha_m on 28/05/26.
//

import Foundation
import SwiftUI

enum AuthType {
    case login
    case register
}

struct AuthView: View {

    @Environment(\.colorScheme) private var colorScheme

    @StateObject var presenter: AuthPresenter

    @State private var email: String = ""
    @State private var password: String = ""

    @FocusState private var isEmailFocused
    @FocusState private var isPasswordFocused

    @State private var hasAgreedToAgreement = false
    @State private var showPass = false
    @State private var authType: AuthType = .login

    var body: some View {

        ZStack {
            // 🌈 Background upgrade
            LinearGradient(
                colors: colorScheme == .light
                ? [Color.blue.opacity(0.15), Color.white]
                : [Color.black, Color(.systemGray6)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView(showsIndicators: false) {

                VStack(spacing: 18) {

                    TopView()
                        .padding(.top, 20)

                    SegmentedView(authType: $authType)

                    // 🧊 Card container
                    VStack(spacing: 18) {

                        TextField("Email", text: $email)
                            .focused($isEmailFocused)
                            .textFieldStyle(AuthTextFieldStyle(isFocused: $isEmailFocused))

                        ZStack {

                            SecureField("Password", text: $password)
                                .focused($isPasswordFocused)
                                .textFieldStyle(AuthTextFieldStyle(isFocused: $isPasswordFocused))
                                .opacity(showPass ? 0 : 1)

                            TextField("Password", text: $password)
                                .focused($isPasswordFocused)
                                .textFieldStyle(AuthTextFieldStyle(isFocused: $isPasswordFocused))
                                .opacity(showPass ? 1 : 0)

                            HStack {
                                Spacer()
                                Button {
                                    withAnimation {
                                        showPass.toggle()
                                    }
                                } label: {
                                    Image(systemName: showPass ? "eye.fill" : "eye.slash.fill")
                                        .foregroundStyle(.gray)
                                        .padding(.trailing, 18)
                                }
                            }
                        }

                        if authType == .register {
                            HStack(alignment: .top) {
                                Toggle(isOn: $hasAgreedToAgreement) {}
                                    .toggleStyle(AgreedStyle())

                                Text("I agree to the **Terms** and **Privacy Policy**.")
                                    .font(.system(size: 14))
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.top, 4)
                        }
                    }
                    .padding(20)
                    .background(.ultraThinMaterial)
                    .cornerRadius(22)
                    .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 6)
                    .padding(.horizontal)

                    Button {

                        if authType == .register {
                            presenter.register(email: email, password: password)
                        } else {
                            presenter.login(email: email, password: password)
                        }

                    } label: {
                        Text(authType == .login ? "Login" : "Register")
                    }
                    .buttonStyle(AuthButtonType())

                    if !presenter.message.isEmpty {
                        Text(presenter.message)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 14, weight: .medium))
                            .padding(.horizontal)
                    }

                    BottomView(authType: $authType)
                        .padding(.bottom, 30)
                }
                .padding()
            }
            .gesture(
                TapGesture().onEnded {
                    isEmailFocused = false
                    isPasswordFocused = false
                }
            )
        }
    }
}
struct AuthButtonType: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .foregroundStyle(.white)
            .font(.system(size: 18, weight: .bold, design: .rounded))
            .background(
                LinearGradient(
                    colors: [.blue, .purple],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: .blue.opacity(0.25), radius: 10, x: 0, y: 6)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .opacity(configuration.isPressed ? 0.85 : 1)
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }
}
struct AuthTextFieldStyle: TextFieldStyle {
    @Environment(\.colorScheme) private var colorScheme

    let isFocused: FocusState<Bool>.Binding

    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .font(.system(size: 16, weight: .medium, design: .rounded))
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(colorScheme == .light ? Color.white : Color(.systemGray5))
                    .shadow(color: .black.opacity(isFocused.wrappedValue ? 0.12 : 0.05),
                            radius: isFocused.wrappedValue ? 8 : 4,
                            x: 0,
                            y: 3)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(isFocused.wrappedValue ? Color.blue.opacity(0.7) : Color.clear, lineWidth: 1.2)
            )
            .animation(.easeInOut(duration: 0.2), value: isFocused.wrappedValue)
    }
}
struct TopView: View {
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 75)
            
            Text("AuthFlow")
                .font(.system(size: 35, weight: .bold, design: .rounded))
        }
    }

}

struct SegmentedView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Binding var authType: AuthType
    
    var body: some View {

        HStack(spacing:0) {
            Button {
                withAnimation {
                    authType = .login
                }
            } label: {
                Text("Login")
                    .fontWeight(authType == .login ? .semibold : .regular)
                    .foregroundStyle(authType == .login ? (colorScheme == .light ? Color(uiColor: UIColor.darkGray) : .white) : .gray)
                    .padding(.vertical, 12)
                    .padding(.horizontal, authType == .login ? 30 : 20)
                    .background(ZStack{
                        if authType == .login {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black.opacity(0.3),
                                        lineWidth: 0.5)
                                .zIndex(1)
                        }
                        RoundedRectangle(cornerRadius: 20)
                            .fill(authType == .login ?
                                  Color(UIColor.systemGray5) :
                                    Color(UIColor.systemGray6))
                            .zIndex(0)
                    })
                
            }
            Button {
                withAnimation {
                    authType = .register
                }
            } label: {
                Text("Register")
                    .fontWeight(authType == .register ? .semibold : .regular)
                    .foregroundStyle(authType == .register ? (colorScheme == .light ? Color(uiColor: UIColor.darkGray) : .white) : .gray)
                    .padding(.vertical, 12)
                    .padding(.horizontal, authType == .register ? 30 : 20)
                    .background(ZStack{
                        if authType == .register {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black.opacity(0.3),
                                        lineWidth: 0.5)
                                .zIndex(1)
                        }
                        RoundedRectangle(cornerRadius: 20)
                            .fill(authType == .register ?
                                  Color(UIColor.systemGray5) :
                                    Color(UIColor.systemGray6))
                            .zIndex(0)
                    })
                
            }
        }
        .background(
            Color(UIColor.systemGray6)
        )
        .cornerRadius(20)
        .padding(.horizontal,20)
        .padding(.bottom, 10)
        .frame(maxWidth: .infinity)
    }
}

struct BottomView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Binding var authType: AuthType
    
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 3) {
                Text(authType == .login ? "Don't have an account?" : "Already have an account?")
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                
                Button {
                    if authType == .login {
                        withAnimation {
                            authType = .register
                        }
                    }
                    else {
                        withAnimation {
                            authType = .login
                        }
                    }
                } label: {
                    Text(authType == .login ? "Register" : "Login")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                    
                }
                
            }
            HStack {
                Rectangle()
                    .frame(height: 1.5)
                    .foregroundStyle(Color.gray.opacity(0.3))
                
                Text("OR")
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                Rectangle()
                    .frame(height: 1.5)
                    .foregroundStyle(Color.gray.opacity(0.3))
            }
            HStack(spacing: 20) {
                //apple
                Button {
                    
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1.5)
                        .frame(width: 40,height: 40)
                        .foregroundStyle(Color.gray.opacity(0.3))
                        .overlay {
                            Image(systemName: "apple.logo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20)
                                .foregroundStyle(colorScheme == .light ? .black : .white)
                            
                        }
                }
                //google
                Button {
                    
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1.5)
                        .frame(width: 40,height: 40)
                        .foregroundStyle(Color.gray.opacity(0.3))
                        .overlay {
                            Image("google-logo")
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20)
                                .foregroundStyle(colorScheme == .light ? .black : .white)
                            
                        }
                }
                
            }
        }
    }
    
}
struct AgreedStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 20)
                .contentTransition(.opacity)
        }
        .tint(.primary)
    }
}
