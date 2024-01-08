//
//  File.swift
//  Muscle Volume
//
//  Created by Babak Kiaie on 1/5/24.
//
import SwiftData
import Foundation

@Model
class Routine: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    var name: String
    var workouts: [Workout]?

    init(name: String, workouts: [Workout]? = nil) {
        self.name = name
        self.workouts = workouts
    }
}

@Model
class Workout: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    var name: String
    var exercises: [Exercise]?

    init(name: String, exercises: [Exercise]? = nil) {
        self.name = name
        self.exercises = exercises
    }
}

@Model
class Exercise: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    var name: String
    var primaryMuscle: String
    var secondaryMuscle: String?

    init(name: String, primaryMuscle: String, secondaryMuscle: String? = nil) {
        self.name = name
        self.primaryMuscle = primaryMuscle
        self.secondaryMuscle = secondaryMuscle
    }
}
