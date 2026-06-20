//
//  ProfileView.swift
//  Learning
//
//  Created by vasantha_m on 25/04/26.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var presenter: ProfilePresenter
    
    @State private var showCourses = false
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 0) {
                
                // MARK: - Header
                ZStack(alignment: .top) {
                    
                    LinearGradient(
                        colors: [.black,.blue],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .frame(height: 280)
                    
                    VStack(spacing: 10) {
                        
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 120, height: 120)
                            .foregroundColor(.white)
                            .padding(.top, 40)
                        
                        Text(presenter.user.email
                            .components(separatedBy: "@")
                            .first ?? "User")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        
                        Text(presenter.user.email)
                            .foregroundColor(.white.opacity(0.8))
                        
                        
                        Text("Student")
                            .foregroundColor(.white.opacity(0.8))
                    }
                }
                
                // MARK: - Stats
                HStack(spacing: 40) {
                    
                    StatView(
                        icon: "book.fill",
                        number: "\(presenter.courses.count)",
                        title: "Courses"
                    )
                    
                    StatView(
                        icon: "checkmark.circle.fill",
                        number: "\(presenter.completedCourses)",
                        title: "Completed"
                    )
                    
                    StatView(
                        icon: "rosette",
                        number: "\(presenter.certificatesCount)",
                        title: "Certificates"
                    )
                    ZStack {
                        
                        Circle()
                            .stroke(.white.opacity(0.2), lineWidth: 12)
                        
                        Circle()
                            .trim(
                                from: 0,
                                to: min(
                                    presenter.overallProgress,
                                    1.0
                                )
                            )
                            .stroke(
                                LinearGradient(
                                    colors: [.purple, .blue],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ),
                                style: StrokeStyle(
                                    lineWidth: 12,
                                    lineCap: .round
                                )
                            )
                            .rotationEffect(.degrees(-90))
                        
                        VStack {
                            
                            Text("\(Int(presenter.overallProgress * 100))%")
                                .font(.title.bold())
                            
                            Text("Progress")
                                .font(.caption)
                        }
                    }
                    .frame(width: 120, height: 120)
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .padding(.horizontal)
                .offset(y: -20)
                
                ActionButtons()
                
                AchievementsSection(achievements: presenter.achievements)
                
                // MARK: - Enrolled Courses
                VStack(alignment: .leading, spacing: 15) {
                    
                    Button {
                        withAnimation(.spring(Spring(response: 0.35, dampingRatio: 0.8))){
                            showCourses.toggle()
                        }
                    } label: {
                        
                        HStack {
                            
                            Text("Enrolled Courses")
                                .font(.headline)
                            
                            Spacer()
                            
                            Image(systemName:
                                    showCourses
                                  ? "chevron.down"
                                  : "chevron.right")
                        }
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(15)
                    }
                    
                    if showCourses {
                        
                        ForEach(presenter.courses, id: \.id) { course in
                            
                            
                            HStack(spacing: 15) {
                                
                                Image(course.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 80, height: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 18))
                                
                                VStack(alignment: .leading,spacing: 8) {
                                    
                                    Text(course.title)
                                        .font(.headline)
                                    
                                    Text(course.description)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    
                                    ProgressView(
                                        value: presenter.progressForCourse(course)
                                    )
                                    .tint(.indigo)
                                }
                                
                                Spacer()
                                
                                Image(systemName: "play.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.indigo)
                            }
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(22)
                        }
                    }
                }
                .padding()
                
                // MARK: - Logout
                Button {
                    presenter.logoutTapped()
                } label: {
                    Text("Logout")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                colors: [.red,.pink],startPoint: .leading,endPoint: .trailing
                            )
                        )
                        .cornerRadius(15)
                }
                .padding()
            }
        }
        .background(.gray.opacity(0.5))
        .ignoresSafeArea()
        .onAppear{
            presenter.reloadProfileStats()
        }
        
    }
}

struct AchievementsSection: View {
    
    let achievements: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            
            Text("Achievements")
                .font(.headline)
            
            LazyVGrid(
                columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ],
                spacing: 12
            ) {
                
                ForEach(achievements, id: \.self) { achievement in
                    
                    switch achievement {
                        
                    case "lecture_completed":
                        
                        AchievementCard(
                            icon: "checkmark.circle.fill",
                            color: .green,
                            title: "Lecture Completed"
                        )
                        
                    case "course_completed":
                        
                        AchievementCard(
                            icon: "graduationcap.fill",
                            color: .blue,
                            title: "Course Completed"
                        )
                        
                    default:
                        EmptyView()
                    }
                }
            }
        }
        .padding()
    }
}
struct AchievementCard: View {
    
    let icon: String
    let color: Color
    let title: String
    
    var body: some View {
        
        VStack(spacing: 10) {
            
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundColor(color)
            
            Text(title)
                .font(.caption)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            LinearGradient(
                colors: [
                    color.opacity(0.25),
                    color.opacity(0.08)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(15)
    }
}
