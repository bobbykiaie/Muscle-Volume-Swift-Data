//
//  WorkoutSessionModel.swift
//  Muscle Volume
//
//  Created by Babak Kiaie on 2/4/24.
//

import Foundation

@Observable
class WorkoutSessionModel {
    
    var sessionStarted: Bool = false
    var startedWorkout: Workout?
    var selectedTab: Int = 0
    
    
//    init(sessionStarted: Bool) {
//        self.sessionStarted = sessionStarted
//        self.selectedTab = 0
//    }
    
}
