//
//  LectureView.swift
//  App
//
//  Created by vasantha_m on 10/06/26.
//

import SwiftUI
import AVKit

struct LectureDetailsView: View {
    
    @StateObject var presenter: LecturePresenter
    
    var body: some View {
        ZStack {
            
            Color(red: 0.12, green: 0.12, blue: 0.18)
                .ignoresSafeArea()
            ScrollView {
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    // MARK: Video
                    
                    VideoPlayer(
                        player: presenter.player
                    )
                    .frame(height: 250)
                    .cornerRadius(12)
                    
                    // MARK: Lecture Info
                    
                    Text(presenter.selectedLecture.title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Duration: \(presenter.selectedLecture.duration)")
                        .foregroundColor(.white)
                    
                    // MARK: Progress
                    
                    VStack(alignment: .leading, spacing: 8) {
                        
                        HStack {
                            
                            Text("Progress")
                            
                            Spacer()
                            
                            Text(
                                "\(Int(presenter.lectureProgress * 100))%"
                                
                            )
                            .foregroundColor(.white)
                        }
                        
                        ProgressView(
                            value: presenter.lectureProgress
                        )
                    }
                    
                    // MARK: Completed
                    
                    if presenter.isCompleted {
                        
                        Label(
                            "Lecture Completed",
                            systemImage: "checkmark.circle.fill"
                        )
                        .foregroundColor(.green)
                    }
                    
                    // MARK: Navigation Buttons
                    
                    HStack {
                        
                        Button("Previous") {
                            presenter.previousLectureTapped()
                        }
                        .disabled(presenter.isFirstLecture)
                        
                        Spacer()
                        
                        Button("Next") {
                            presenter.nextLectureTapped()
                        }
                        .disabled(presenter.isLastLecture)
                    }
                    .padding(.top)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Lecture")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                presenter.viewDidLoad()
            }
        }
    }
}
