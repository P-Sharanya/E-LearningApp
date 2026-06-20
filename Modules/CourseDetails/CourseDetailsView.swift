//
//  CourseDetailsView.swift
//  Learning
//
//  Created by vasantha_m on 24/04/26.
//


import SwiftUI

struct CourseDetailsView: View {

    @StateObject var presenter: CourseDetailsPresenter
    private let cardWidth: CGFloat = 350

    var body: some View {
        ZStack {
            Color(red: 0.12, green: 0.12, blue: 0.18)
                .ignoresSafeArea()


            ScrollView(showsIndicators: false) {
                VStack(spacing: 18) {

                    headerView

                    progressView

                    continueLearnView

                    learnView

                    lecturesListView

                    enrollButtonView
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 40)
            }
        }
        .animation(.spring(response: 0.4), value: presenter.isEnrolled)
        .animation(.spring(response: 0.4), value: presenter.courseProgress)
    }

    // MARK: Header

    private var headerView: some View {

        let course = presenter.course

        return ZStack(alignment: .bottomLeading) {

            Image(course.imageName)
                .resizable()
                .scaledToFit()

            LinearGradient(
                colors: [
                    .clear,
                    .black.opacity(0.85)
                ],
                startPoint: .top,
                endPoint: .bottom
            )

            VStack(alignment: .leading, spacing: 10) {

                Text(course.title)
                    .font(.system(size: 30, weight: .bold))

                Text(course.description)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.85))
                    .lineLimit(3)

                HStack {

                    Label(course.instructor,
                          systemImage: "person.fill")

                    Spacer()

                    Label(
                        "\(course.rating, specifier: "%.1f")",
                        systemImage: "star.fill"
                    )
                }
                .font(.caption)
            }
            .foregroundColor(.white)
            .padding()
        }
    }

    // MARK: Progress

    @ViewBuilder
    private var progressView: some View {

        if presenter.isEnrolled {

            VStack(alignment: .leading, spacing: 16) {

                Text("Your Progress")
                    .font(.headline)
                    .foregroundColor(.white)

                ProgressView(value: presenter.courseProgress)
                    .tint(.green)
                    .scaleEffect(y: 1.8)

                Text("\(Int(presenter.courseProgress * 100))% Complete")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.green)

                HStack(spacing: 12) {

                    CourseStatView(
                        icon: "play.rectangle.fill",
                        value: "\(presenter.lectures.count)",
                        title: "Lectures"
                    )

                    CourseStatView(
                        icon: "clock.fill",
                        value: presenter.course.durations,
                        title: "Duration"
                    )

                    CourseStatView(
                        icon: "doc.text.fill",
                        value: "\(presenter.lectures.count)",
                        title: "Projects"
                    )
                }
            }
            .padding()
            .background(glassCard)
        }
    }

    // MARK: Continue Learning

    @ViewBuilder
    private var continueLearnView: some View {

        if presenter.isEnrolled &&
            presenter.courseProgress < 1 {

            Button {
                presenter.continueLearningTapped()
            } label: {

                HStack(spacing: 10) {

                    Image(systemName: "play.fill")

                    Text("Continue Learning")
                        .fontWeight(.bold)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    LinearGradient(
                        colors: [.blue, .purple],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(20)
                .shadow(
                    color: .blue.opacity(0.4),
                    radius: 15,
                    y: 8
                )
            }
        }
    }

    // MARK: Learn Section

    private var learnView: some View {

        VStack(alignment: .leading, spacing: 10) {

            Text("What You'll Learn")
                .font(.title2.bold())
                .foregroundColor(.white)

            ForEach(
                presenter.course.whatYouWillLearn,
                id: \.self
            ) { item in

                LearnRow(text: item)
            }
        }
        .padding()
        .background(glassCard)
    }

    // MARK: Lectures

    private var lecturesListView: some View {

        VStack(alignment: .leading, spacing: 16) {

            Text("Course Lectures")
                .font(.title2.bold())
                .foregroundColor(.white)

            ForEach(
                Array(presenter.lectures.enumerated()),
                id: \.element.id
            ) { index, lecture in

                Button {
                    presenter.lectureTapped(lecture)
                } label: {

                    VStack(alignment: .leading, spacing: 16) {

                        HStack(alignment: .top, spacing: 15) {

                            ZStack {

                                Circle()
                                    .fill(
                                        LinearGradient(
                                            colors: [
                                                .white.opacity(0.25),
                                                .white.opacity(0.08)
                                            ],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 50, height: 50)

                                if lecture.progress == 1 {

                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)

                                } else if lecture.progress > 0 {

                                    Image(systemName: "play.circle.fill")
                                        .foregroundColor(.orange)

                                } else {

                                    Image(systemName: "circle")
                                        .foregroundColor(.gray)
                                }
                            }

                            VStack(
                                alignment: .leading,
                                spacing: 6
                            ) {

                                Text("Lecture \(index + 1)")
                                    .font(.caption)
                                    .foregroundColor(
                                        .white.opacity(0.6)
                                    )

                                Text(lecture.title)
                                    .font(.headline)
                                    .lineLimit(2)
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.white)

                                Text(lecture.duration)
                                    .font(.caption)
                                    .foregroundColor(
                                        .white.opacity(0.7)
                                    )
                            }

                            Spacer()

                            Text(
                                "\(Int(lecture.progress * 100))%"
                            )
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                        }

                        ProgressView(
                            value: lecture.progress
                        )
                        .tint(.green)
                        .scaleEffect(y: 1.5)
                    }
                    .padding(16)
                    .background(
                        RoundedRectangle(
                            cornerRadius: 24
                        )
                        .fill(.white.opacity(0.08))
                    )
                    .overlay(
                        RoundedRectangle(
                            cornerRadius: 24
                        )
                        .stroke(
                            .white.opacity(0.12),
                            lineWidth: 1
                        )
                    )
                    .shadow(
                        color: .black.opacity(0.25),
                        radius: 10,
                        y: 5
                    )
                }
                .buttonStyle(.plain)
            }
        }
    }

    // MARK: Enroll Button

    private var enrollButtonView: some View {

        Button {

            if presenter.isEnrolled {
                presenter.withdrawTapped()
            } else {
                presenter.enrollTapped()
            }

        } label: {

            Text(
                presenter.isEnrolled
                ? "Withdraw"
                : "Enroll Now"
            )
            .font(.headline)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(
                LinearGradient(
                    colors: presenter.isEnrolled
                    ? [.red, .orange]
                    : [.green, .mint],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(22)
            .shadow(
                color: presenter.isEnrolled
                ? .red.opacity(0.35)
                : .green.opacity(0.35),
                radius: 15,
                y: 8
            )
        }
    }

    // MARK: Reusable Glass Card

    private var glassCard: some View {
        RoundedRectangle(cornerRadius: 28)
            .fill(.white.opacity(0.06))
            .overlay(
                RoundedRectangle(cornerRadius: 28)
                    .stroke(.white.opacity(0.10))
            )
    }
}


#Preview {

    let lectures = [
        Lecture(
            id: "lecture1",
            title: "Introduction to SwiftUI",
            duration: "15 min",
            videoUrl: "",
            progress: 1.0,
            isLocked: false
        ),
        Lecture(
            id: "lecture2",
            title: "Stacks and Layouts",
            duration: "22 min",
            videoUrl: "",
            progress: 0.5,
            isLocked: false
        ),
        Lecture(
            id: "lecture3",
            title: "Navigation",
            duration: "18 min",
            videoUrl: "",
            progress: 0.0,
            isLocked: true
        )
    ]

    let course = Course(
        id: "course1",
        title: "SwiftUI Masterclass",
        imageName: "course_banner", 
        description: "Build beautiful iOS apps with SwiftUI from beginner to advanced.",
        durations: "12h 30m",
        rating: 4.8,
        whatYouWillLearn: [
            "SwiftUI Layout System",
            "NavigationStack",
            "MVVM Architecture",
            "Animations & Transitions"
        ],
        lectures: lectures,
        instructor: "John Appleseed",
        students: 1250
    )

    let presenter = CourseDetailsPresenter(
        course: course,
        interactor: CourseDetailsInteractor(),
        router: CourseDetailsRouter(
            onEnroll: {},
            onLectureSelected: { _ in }
        )
    )

    return CourseDetailsView(
        presenter: presenter
    )
}

