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
  
    var exercises: [Exercise] = [Exercise]()
    var workoutStarted: Bool? = false

    init(name: String = "") {
        self.name = name

    }
    var musclesWorked: [MuscleGroup] {
        var allMuscles = Set<MuscleGroup>()
        for exercise in exercises {
            allMuscles.insert(exercise.primaryMuscle)
            if let secondaryMuscle = exercise.secondaryMuscle {
                allMuscles.insert(secondaryMuscle)
            }
        }
        return Array(allMuscles)
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
