//
//  ProfilePresenter.swift
//  Learning
//
//  Created by vasantha_m on 25/04/26.
//

import Foundation

class ProfilePresenter: ObservableObject {
    
    private let interactor: ProfileInteractor
    private let router: ProfileRouter
    
    @Published var user: User
    @Published var courses: [Course]
    
    @Published var achievements: [String]
    @Published var completedCourses: Int
    @Published var certificatesCount: Int
    @Published var overallProgress: Double
    
    init(interactor: ProfileInteractor,
         router: ProfileRouter) {
        
        self.interactor = interactor
        self.router = router
        
        self.user = interactor.user
        self.courses = interactor.courses
        
        let profile =
        LearningProfileRepository.shared.load()
        
        self.completedCourses =
        profile.courseProgress.values
            .filter { $0 >= 1.0 }
            .count
        
        self.achievements =
        profile.achievements
        
        self.certificatesCount =
        profile.certificates.count
        
        if profile.courseProgress.isEmpty {
            
            self.overallProgress = 0
            
        } else {
            
            self.overallProgress =
            profile.courseProgress.values.reduce(0,+)
            / Double(profile.courseProgress.count)
        }
        
    }
    
    func logoutTapped() {
        router.goToLogin()
    }
    func progressForCourse(
        _ course: Course
    ) -> Double {
        
        let profile =
        LearningProfileRepository.shared.load()
        
        return profile.courseProgress[
            course.id
        ] ?? 0
    }
    func reloadProfileStats() {
        
        let profile =
        LearningProfileRepository.shared.load()
        
        completedCourses =
        profile.courseProgress.values
            .filter { $0 >= 1 }
            .count
        
        certificatesCount =
        profile.certificates.count
        
        overallProgress =
        profile.courseProgress.values.reduce(0,+)
        / max(
            Double(profile.courseProgress.count),
            1
        )
        
        achievements =
        profile.achievements
    }
}
