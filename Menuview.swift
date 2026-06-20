//
//  Menuview.swift
//  App
//
//  Created by vasantha_m on 04/06/26.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 15) {
                Circle()
                    .fill(
                        LinearGradient(colors: [.blue,.purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .frame(width: 70)
                    .overlay(
                        Image(systemName: "person.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                        
                    )
                    .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 5)
                VStack(alignment: .leading, spacing: 5) {
                    Text("John Doe")
                        .font(.title2.bold())
                    Text("premium Member")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .padding(.top, 60)
            .padding(.horizontal)
            
            Rectangle()
                .fill(
                    LinearGradient(colors: [.clear,.gray.opacity(0.2),.clear], startPoint: .leading, endPoint: .trailing)
                )
                .frame(height: 1)
                .padding(.vertical, 30)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 5){
                    ForEach(menuItems) { item in
                        MenuItemView(menuItem: item)
                    }
                }
            }
            VStack(spacing: 20) {
                Button(action: {}){
                    HStack {
                        Image(systemName: "arrow.right.square.fill")
                        Text("Logout")
                    }
                    .foregroundColor(.red)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.red.opacity(0.5), lineWidth: 1)
                    )
                }
                Text("App Version 1.0")
                    .font(.caption)
                    .foregroundColor(.gray)
                
            }
            .padding()
            .padding(.bottom,30)
        }
    }
}
struct ContentView: View{
    @State private var isShowingMenu = false
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    menuButton
                    Spacer()
                }
                Spacer()
                subscribeSection
                Spacer()
            }
            .blur(radius: isShowingMenu ? 5 : 0)
            
            sideMenu
        }
    }
    private var menuButton: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)){
                isShowingMenu.toggle()
            }
        }){
            Image(systemName: "line.horizontal.3")
                .imageScale(.large)
                .foregroundColor(.primary)
                .rotationEffect(Angle(degrees: isShowingMenu ? 90 : 0))
                .padding(12)
                .background(
                    Circle()
                        .fill(Color.gray.opacity(0.1))
                        .shadow(color: .gray.opacity(0.2),radius: 5, x: 0, y: 2)
                )
        }
        .padding()
    }
    
    private var subscribeSection: some View {
        VStack(spacing: 20){
            Image(systemName: "star.circle.fill")
                .imageScale(.large)
                .foregroundColor(.yellow)
                .font(.system(size: 40))
            
            Text("Subscribe to Support")
                .font(.title2.bold())
                .foregroundColor(.primary)
            
            Text("Help us continue creating amazing content")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(color: .gray.opacity(0.2),radius: 10, x: 0, y: 5)
        )
        .padding()
    }
    
    private var sideMenu: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                MenuView()
                    .frame(width: min(geometry.size.width * 0.75, 300))
                    .frame(maxHeight: .infinity)
                    .background(
                        ZStack {
                            Color(.systemBackground)
                            
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [.blue.opacity(0.2),.purple.opacity(0.2)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 200, height: 200)
                                .blur(radius: 50)
                                .offset(x: -100, y: -50)
                            
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [.orange.opacity(0.2),.red.opacity(0.2)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 200, height: 200)
                                .blur(radius: 50)
                                .offset(x: 50, y: geometry.size.height - 100)
                        }
                    )
                    .clipShape(
                        RoundedCornerShape(radius: 30, corners: [.topRight, .bottomRight])
                    )
                    .shadow(color: .black, radius: 20, x: 5, y: 0)
                    .offset(x: isShowingMenu ? 0 : -geometry.size.width)
                
                Spacer()
            }
            .background(
                Color.black.opacity(isShowingMenu ? 0.3 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)){
                            isShowingMenu = false
                        }
                    }
            )
        }
        .ignoresSafeArea()
        .animation(.spring(response: 0.3,dampingFraction: 0.8), value: isShowingMenu)
    }
}
struct MenuItem: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let color: Color
}

let menuItems = [
    MenuItem(icon: "house.fill",title: "Home",color: .blue),
    MenuItem(icon: "person.fill", title: "Profile",color: .purple),
    MenuItem(icon: "bell.fill",title: "Notifications",color: .red),
    MenuItem(icon: "gear",title: "Settings",color: .orange),
    MenuItem(icon: "star.fill",title: "Favorites",color: .yellow),
    MenuItem(icon: "envelope.fill",title: "Messages",color: .green)
]
struct RoundedCornerShape: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(
                width: radius,
                height: radius
            )
        )

        return Path(path.cgPath)
    }
}
struct MenuItemView: View {
    let menuItem: MenuItem

    @State private var isHovered = false

    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: menuItem.icon)
                .foregroundColor(menuItem.color)
                .imageScale(.large)
                .frame(width: 32, height: 32)
                .background(
                    Circle()
                        .fill(menuItem.color.opacity(0.1))
                )

            Text(menuItem.title)
                .foregroundColor(.primary)
                .font(.headline)

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.gray.opacity(0.5))
                .opacity(isHovered ? 1 : 0)
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(
                    isHovered
                        ? menuItem.color.opacity(0.1)
                        : Color.clear
                )
        )
        .contentShape(Rectangle())
        .onHover { hovering in
            withAnimation(.easeInOut(duration: 0.2)) {
                isHovered = hovering
            }
        }
        .onTapGesture {
            withAnimation(.spring(response: 0.3,dampingFraction: 0.8 )) {
                // Handle menu item tap
            }
        }
    }
}
#Preview {
    MenuView()
}
