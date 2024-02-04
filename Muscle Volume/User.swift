//
//  User.swift
//  Muscle Volume
//
//  Created by Babak Kiaie on 1/30/24.
//

import Foundation


@Observable
class User {
    var workoutStarted: Bool = false
    var workout: Workout?
    var selectedTab: Int = 0
    
//    init(workoutStarted: Bool, workout: Workout? = nil, selectedTab: Int) {
//        self.workoutStarted = false
//        self.workout = workout
//        self.selectedTab = selectedTab
//    }
    
}
