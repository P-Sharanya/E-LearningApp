//
//  ProfileEntity.swift
//  Learning
//
//  Created by vasantha_m on 25/04/26.
//


import UIKit
import SwiftUI

class LearningProfileRepository {
    
    static let shared = LearningProfileRepository()
    
    private init() {}
    
    private let fileName = "learning_profile_<uid>.json"
    
    
    private var fileURL: URL {
        
        FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        )[0]
            .appendingPathComponent(fileName)
    }
    
    func load() -> UserLearningProfile {
        
        if let data = try? Data(contentsOf: fileURL),
           let profile = try? JSONDecoder()
            .decode(UserLearningProfile.self,
                    from: data) {
            
            return profile
        }
        
        return UserLearningProfile(
            uid: "",
            enrolledCourses: [],
            courseProgress: [:],
            lectureProgress: [:],
            achievements: [],
            certificates: [],
            streakDays: 0
        )
    }
    func save(
        _ profile: UserLearningProfile
    ) {
        
        guard let data =
                try? JSONEncoder().encode(profile)
        else {
            return
        }
        
        try? data.write(to: fileURL)
    }
}
