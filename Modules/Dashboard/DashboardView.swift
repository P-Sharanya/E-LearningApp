//
//  DashboardView.swift
//  Learning
//
//  Created by vasantha_m on 25/03/26.
//

import SwiftUI

struct DashboardView: View {

    @StateObject var presenter: DashboardPresenter
    @State private var isShowingMenu = false
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ZStack {

            dashboardContent

            sideMenu
        }
        .onAppear {
            presenter.load()
        }
    }

    // MARK: - MAIN CONTENT

    private var dashboardContent: some View {
        
        ZStack {
            
            Color(red: 0.12, green: 0.12, blue: 0.18)
                .ignoresSafeArea()

            VStack(spacing: 0) {

                topBarView

                searchBarView

                ScrollView(showsIndicators: false) {

                    VStack(spacing: 28) {

                        continueLearningView
                        
                        carouselView
                        
                        popularCoursesSection
                        
                        recentlyAddedView
                        
                        upcomingCoursesView
                    }
                    .padding(.top, 24)
                    .padding(.bottom, 20)
                }

                toolbarView
            }
        }
        .blur(radius: isShowingMenu ? 5 : 0)
    }
    
    // MARK: - HEADER
    
    private var topBarView: some View {
        
        HStack(alignment: .top) {
            
            Button {
                withAnimation(.spring(response: 0.3,
                                      dampingFraction: 0.8)) {
                    isShowingMenu.toggle()
                }
            } label: {
                
                Image(systemName: "line.horizontal.3")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 44, height: 44)
                    .background(
                        Circle()
                            .fill(.white.opacity(0.12))
                    )
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Hello there! 👋")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                
                Text("Ready to continue learning?")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.75))
            }
            
            Spacer()
            
            Button {
                presenter.profileTapped()
            } label: {
                
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48)
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 12)
    }
    
    // MARK: - SEARCH BAR
    
    private var searchBarView: some View {
        
        HStack(spacing: 12) {

            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)

            TextField(
                "Search courses...",
                text: $presenter.searchText
            )
            .foregroundColor(.black)

            if !presenter.searchText.isEmpty {

                Button {
                    presenter.searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(18)
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
    
    // MARK: - CONTINUE LEARNING
    
    @ViewBuilder
    private var continueLearningView: some View {
        
        if let course = presenter.courses.last {
            Button {
                presenter.didSelect(course: course)
            } label: {
                ContinueLearningCard(
                    course: course,
                    progress: 0.7
                )
            }
        }
    }
    // MARK: - FEATURED CAROUSEL
    
    private var carouselView: some View {
        
        TabView {
            
            ForEach(presenter.carouselCourse) { course in
                Button {
                    presenter.didSelect(course: course)
                } label: {
                    ZStack(alignment: .bottomLeading) {
                        
                        Image(course.imageName)
                            .resizable()
                        
                        
                        LinearGradient(
                            colors: [
                                .clear,
                                .black.opacity(0.75)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        
                        VStack(alignment: .leading, spacing: 8) {
                            
                            Text(course.title)
                                .font(.system(size: 18,weight: .bold))
                                .foregroundColor(.white)
                            
                            Text("Featured Course")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        .padding(20)
                    }
                    .clipShape(
                        RoundedRectangle(cornerRadius: 26)
                    )
                    .padding(.horizontal, 20)
                }
            }
        }
        .frame(height: 220)
        .tabViewStyle(.page(indexDisplayMode: .automatic))
    }
    
    // MARK: - POPULAR COURSES
    
    private var popularCoursesSection: some View {
        
        VStack(alignment: .leading, spacing: 18) {
            
            sectionTitle("Popular Courses")
            
            gridView
        }
    }
    
    private func sectionTitle(_ title: String) -> some View {
        
        HStack {
            Text(title)
                .font(.title2.bold())
                .foregroundColor(.white)

            Spacer()
        }
        .padding(.horizontal, 20)
    }
    
    private var gridView: some View {
        
        LazyVGrid(columns: columns, spacing: 18) {
            
            ForEach(presenter.courses, id: \.id) { course in
                
                Button {
                    presenter.didSelect(course: course)
                } label: {
                    
                    VStack(alignment: .center, spacing: 12) {
                        
                        Image(course.imageName)
                            .resizable()
                            .cornerRadius(14)
                            .frame(height: 120)
                        
                        Text(course.title)
                            .font(.headline)
                            .foregroundColor(.white)
                            .lineLimit(2)
                        
                        HStack {
                            
                            Label("5", systemImage: "star.fill")
                            
                            Spacer()
                            
                            Label(course.durations, systemImage: "clock")
                        }
                        .font(.footnote)
                        .foregroundColor(.white)
                    }
                    .padding(14)
                    .overlay(
                        RoundedRectangle(cornerRadius: 22)
                            .stroke(.white.opacity(0.8))
                    )
                }
            }
        }
        .padding(.horizontal, 20)
    }

    // MARK: - RECENTLY ADDED
    
    private var recentlyAddedView: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            
            sectionTitle("Recently Added")
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack(spacing: 16) {
                    
                    ForEach(presenter.recentlyAddedCourses) { course in
                        Button {
                            presenter.didSelect(course: course)
                        } label: {
                            VStack(alignment: .leading, spacing: 10) {
                                
                                Image(course.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 210, height: 130)
                                    .clipped()
                                
                                Text(course.title)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .lineLimit(2)
                                    .padding(.horizontal, 12)
                                
                                Spacer()
                            }
                            .frame(width: 210, height: 210)
                            .overlay(
                                RoundedRectangle(cornerRadius: 22)
                                    .stroke(.white.opacity(0.8))
                            )
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
    
    // MARK: - UPCOMING COURSES
    
    private var upcomingCoursesView: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            
            sectionTitle("Upcoming Courses")
            
            ForEach(
                Array(presenter.upcomingCourses.enumerated()),
                id: \.offset
            ) { _, item in
                if let course = item.course {
                    
                    Button {
                        presenter.didSelect(course: course)
                    } label: {
                        
                        HStack(spacing: 16) {
                            
                            Image(systemName: "calendar")
                                .font(.title3)
                                .foregroundColor(.blue)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                
                                Text(course.title)
                                    .font(.headline)
                                    .foregroundColor(.black)
                                
                                Text(item.date)
                                    .font(.caption)
                                    .foregroundColor(.black)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(.secondary)
                        }
                        .padding(18)
                        .background(Color.white)
                        .cornerRadius(20)
                    }
                }
            }
        }
        .padding(.horizontal, 20)
    }
    
    // MARK: - TOOLBAR
    
    private var toolbarView: some View {
        
        HStack {
            
            Spacer()
            
            Button(action: {}) {
                
                VStack {
                    Image(systemName: "house.fill")
                    Text("Home")
                        .font(.caption2)
                }
            }
            
            Spacer()
            
            Button(action: {}) {
                
                VStack {
                    Image(systemName: "book.fill")
                    Text("Courses")
                        .font(.caption2)
                }
            }
            
            Spacer()
            
            Button {
                presenter.profileTapped()
            } label: {
                
                VStack {
                    Image(systemName: "person.fill")
                    Text("Profile")
                        .font(.caption2)
                }
            }
            
            Spacer()
        }
        .padding(.vertical, 12)
        .background(Color.white)
        .cornerRadius(25)
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
    }
    
    // MARK: - SIDE MENU
    
    private var sideMenu: some View {
        
        GeometryReader { geometry in
            
            HStack(spacing: 0) {
                
                MenuView()
                    .frame(width: min(geometry.size.width * 0.75, 300))
                    .frame(maxHeight: .infinity)
                    .background(Color.white.opacity(0.2))
                    .clipShape(
                        RoundedCornerShape(
                            radius: 30,
                            corners: [.topRight, .bottomRight]
                        )
                    )
                    .shadow(
                        color: .black.opacity(0.3),
                        radius: 20,
                        x: 5,
                        y: 0
                    )
                    .offset( x: isShowingMenu ? 0 : -geometry.size.width )
                
                Spacer()
            }
            .background(
                Color.black.opacity(isShowingMenu ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(
                            .spring(
                                response: 0.3,
                                dampingFraction: 0.8
                            )
                        ) {
                            isShowingMenu = false
                        }
                    }
            )
        }
        .ignoresSafeArea()
        .animation(
            .spring(
                response: 0.3,
                dampingFraction: 0.8
            ),
            value: isShowingMenu
        )
    }
}

// MARK: - CONTINUE LEARNING CARD

struct ContinueLearningCard: View {
    
    let course: Course
    let progress: Double
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(
                colors: [
                    //Color.red.opacity(0.85),
                    Color.teal.opacity(0.8),
                    Color.clear
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            VStack(alignment: .leading, spacing: 16) {
                
                Label(
                    "Continue Learning",
                    systemImage: "play.circle.fill"
                )
                .font(.headline)
                .foregroundColor(.white)
                
                Text(course.title)
                    .font(.title2.bold())
                    .foregroundColor(.white)
                
                ProgressView(value: progress)
                    .tint(.yellow)
                
                HStack {
                    
                    Text("\(Int(progress * 100))% Completed")
                        .font(.caption)
                    
                    Spacer()
                    
                    Text("Resume")
                        .font(.subheadline.bold())
                }
                .foregroundColor(.white)
            }
            .padding(24)
        }
        .frame(height: 180)
        .cornerRadius(28)
        .padding(.horizontal, 20)
    }
}
#Preview {
    
    let user = User(
        uid: "preview_user",
        email: "preview@test.com"
    )
    
    let interactor = DashboardInteractor(user: user)
    
    let router = DashboardRouter(
        openCourse: { _ in },
        openProfile: { _, _ in }
    )
    
    let presenter = DashboardPresenter(
        interactor: interactor,
        router: router
    )
    
    DashboardView(
        presenter: presenter
    )
}
