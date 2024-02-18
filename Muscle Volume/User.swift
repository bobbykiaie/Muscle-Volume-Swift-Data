//
//  User.swift
//  Muscle Volume
//
//  Created by Babak Kiaie on 1/30/24.
//

import Foundation
import SwiftData


@Model
class User {
    var workoutHistory: [CompletedWorkout]
    
    init(workoutHistory: [CompletedWorkout]) {
        self.workoutHistory = workoutHistory
    }
   
    
    
//    init(workoutStarted: Bool, workout: Workout? = nil, selectedTab: Int) {
//        self.workoutStarted = false
//        self.workout = workout
//        self.selectedTab = selectedTab
//    }
    
}


@Model
class CompletedWorkout {
    var workout: Workout
    var muscleVolume = [MuscleGroup: Int]()
    var workoutDate: Date
    var workoutDuration: Int?
    
    
    
    init(workout: Workout, muscleVolume: [MuscleGroup : Int] = [MuscleGroup: Int](), workoutDate: Date) {
        self.workout = workout
        self.muscleVolume = muscleVolume
        self.workoutDate = workoutDate
    }
}
