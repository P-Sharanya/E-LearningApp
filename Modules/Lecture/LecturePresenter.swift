//
//  LecturePresenter.swift
//  App
//
//  Created by vasantha_m on 10/06/26.
//

import SwiftUI
import AVKit

class LecturePresenter: ObservableObject {
    
    @Published var selectedLecture: Lecture
    @Published var player: AVPlayer = AVPlayer()
    
    @Published var lectureProgress: Double = 0
    @Published var isCompleted: Bool = false
    
    private let course: Course
    private let router: LectureRouter
    private let interactor: LectureInteractor
    
    private var currentIndex: Int
    private var timeObserver: Any?
    
    init(
        course: Course,
        lecture: Lecture,
        router: LectureRouter,
        interactor: LectureInteractor
    ) {
        self.course = course
        self.router = router
        self.interactor = interactor
        self.selectedLecture = lecture
        self.currentIndex =
        course.lectures.firstIndex {
            $0.id == lecture.id
        } ?? 0
        
    }
    
    
    func viewDidLoad() {
        
        lectureProgress = selectedLecture.progress
        isCompleted = selectedLecture.progress >= 1
        
        loadVideo()
        startTracking()
        
        
    }
    var isFirstLecture: Bool {
        currentIndex == 0
    }
    
    var isLastLecture: Bool {
        currentIndex == course.lectures.count - 1
    }
    func loadVideo() {
        let fileName = (selectedLecture.videoUrl as NSString)
            .deletingPathExtension
        
        let fileExtension = (selectedLecture.videoUrl as NSString)
            .pathExtension
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension)
                
        else {
            print("Video not found: \(selectedLecture.videoUrl)")
            return
        }
        print(url)
        
        player = AVPlayer(url: url)
        player.play()
    }
    func nextLectureTapped() {
        
        guard currentIndex <
                course.lectures.count - 1
        else { return }
        
        currentIndex += 1
        
        selectedLecture =
        course.lectures[currentIndex]
        
        lectureProgress = selectedLecture.progress
        
        isCompleted = selectedLecture.progress >= 1
        
        loadVideo()
    }
    func previousLectureTapped() {
        
        guard currentIndex > 0
        else { return }
        
        currentIndex -= 1
        
        selectedLecture =
        course.lectures[currentIndex]
        
        lectureProgress = selectedLecture.progress
        
        isCompleted = selectedLecture.progress >= 1
        
        loadVideo()
    }
    
    func startTracking() {
        
        timeObserver = player.addPeriodicTimeObserver(
            forInterval: CMTime(seconds: 1, preferredTimescale: 600),
            queue: .main
        ) { [weak self] time in
            
            guard let self else { return }
            
            let current =
            player.currentTime().seconds
            
            guard
                let duration = player.currentItem?.duration.seconds,
                duration.isFinite,
                duration > 0
            else {
                return
            }
            
            guard duration > 0 else { return }
            
            let progress = current / duration
            
            lectureProgress = progress
            
            //            ProgressRepository.shared.saveProgress(
            //                lectureId: selectedLecture.id,
            //                progress: progress
            //            )
            var profile = LearningProfileRepository.shared.load()
            
            //            profile.lectureProgress[course.id,
            //                                    default:[:]][selectedLecture.id] = progress
            
            var lectures =
            profile.lectureProgress[
                course.id
            ] ?? [:]
            
            lectures[selectedLecture.id] =
            progress
            
            profile.lectureProgress[
                course.id
            ] = lectures
            
            LearningProfileRepository.shared.save(profile)
            
            let percentage = Int(progress * 100)
            
            if percentage != Int(lectureProgress * 100) {
                print("\(percentage)%")
            }
            if progress >= 0.95 {
                
                markLectureCompleted()
            }
            
        }
    }
    func markLectureCompleted() {
        
        guard !isCompleted else { return }
        
        isCompleted = true
        lectureProgress = 1
        //        ProgressRepository.shared
        //            .lectureCompleted(
        //                courseId: course.id,
        //                lectureId: selectedLecture.id
        //            )
        var profile = LearningProfileRepository.shared.load()
        
        if profile.lectureProgress[course.id] == nil {
            profile.lectureProgress[course.id] = [:]
        }
        
        profile.lectureProgress[course.id]?[selectedLecture.id] = 1.0
        
        let completedLectures = profile.lectureProgress[course.id]?
            .values
            .filter { $0 >= 1.0 }
            .count ?? 0
        
        let totalLectures = course.lectures.count
        
        guard totalLectures > 0 else {
            return
        }
        
        let progress = Double(completedLectures) / Double(totalLectures)
        
        profile.courseProgress[course.id] = progress
        
        if progress == 1 {
            
            if !profile.certificates.contains(course.id) {
                profile.certificates.append(course.id)
            }
        }
        
        if !profile.achievements.contains("lecture_completed") {
            profile.achievements.append("lecture_completed")
        }
        
        if progress == 1 &&
            !profile.achievements.contains("course_completed") {
            
            profile.achievements.append("course_completed")
        }
        
        LearningProfileRepository.shared.save(profile)
        print("Lecture completed")
    }
    deinit {
        
        if let observer = timeObserver {
            player.removeTimeObserver(observer)
        }
    }
    
    
}

