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
    var about: String?
  
    @Relationship( deleteRule: .cascade)
    var workouts: [Workout] = [Workout]()

    init(name: String = "") {
        self.name = name
      
    }
}

@Model
class Workout: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    var name: String
    var exercises: [Exercise] = []
    var workoutStarted: Bool? = false
    var muscleSetCounts: [String: Int] = [:]

    init(name: String = "") {
        self.name = name
    }

    func updateMuscleSetCounts() {
        self.muscleSetCounts = [:] // Reset or initialize the counts
        for exercise in exercises {
            let primaryMuscle = exercise.primaryMuscle.rawValue
            muscleSetCounts[primaryMuscle, default: 0] += exercise.set ?? 0
            if let secondaryMuscle = exercise.secondaryMuscle?.rawValue {
                muscleSetCounts[secondaryMuscle, default: 0] += exercise.set ?? 0
            }
        }
    }

    func incrementSetCount(for muscle: MuscleGroup) {
        muscleSetCounts[muscle.rawValue, default: 0] += 1
    }
    func decrementSetCount(for muscle: MuscleGroup) {
        let muscleName = muscle.rawValue
        if let currentCount = muscleSetCounts[muscleName], currentCount > 0 {
            muscleSetCounts[muscleName] = currentCount - 1
        }
        // Optionally handle removing the muscle from the dictionary if its count goes to zero,
        // depending on whether you want to keep muscles with zero sets listed.
    }

    var musclesWorked: [String : Int] {
        return muscleSetCounts
    }
}


@Model
class Exercise: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    var name: String
    var primaryMuscle: MuscleGroup
    var secondaryMuscle: MuscleGroup?
    @Transient
    var exerciseSelected: Bool? = false
    var set: Int?
       var reps: Int? = 0
       var weight: Double? = 0
       var rpe: Int? = 0
    
 
    init(name: String, primaryMuscle: MuscleGroup, secondaryMuscle: MuscleGroup? = nil, set: Int? = 0) {
        self.name = name
        self.primaryMuscle = primaryMuscle
        self.secondaryMuscle = secondaryMuscle
        self.set = set
    }
}

enum MuscleGroup: String, CaseIterable, Codable, Observable {
    case chest
    case back
    case shoulders
    case arms
    case abs
    case legs
    case glutes
    case quadriceps
    case hamstrings
    case calves
    case triceps
    case biceps
    case forearms
    case upperBack = "upper back"
    case lowerBack = "lower back"
    case hipFlexors = "hip flexors"
    case obliques
    case fullBody = "full body"
}