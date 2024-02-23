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
    var muscleSetCounts: [String: Float] = [:]

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

    func incrementSetCount(for muscle: MuscleGroup, by num: Float) {
        muscleSetCounts[muscle.rawValue, default: 0] += num
        
    }
    func decrementSetCount(for muscle: MuscleGroup, by num: Float) {
        muscleSetCounts[muscle.rawValue, default: 0] -= num
        // Optionally handle removing the muscle from the dictionary if its count goes to zero,
        // depending on whether you want to keep muscles with zero sets listed.
    }

    var musclesWorked: [String : Float] {
        return muscleSetCounts
    }
}

struct completeSet: Codable {
    var reps: Int = 0
    var weight: Float = 0.0
    var rpe: Float = 0.0
}


@Model
class Exercise: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    var name: String
    var primaryMuscle: MuscleGroup
    var secondaryMuscle: MuscleGroup?
    @Transient
    var exerciseSelected: Bool? = false
    var set: Float?
       var reps: Int? = 0
       var weight: Double? = 0
       var rpe: Int? = 0
    var setHistory: [completeSet] = []
    
 
    init(name: String, primaryMuscle: MuscleGroup, secondaryMuscle: MuscleGroup? = nil, set: Float? = 0) {
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
