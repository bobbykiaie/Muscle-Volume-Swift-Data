//
//  MainTabBar.swift
//  Muscle Volume
//
//  Created by Babak Kiaie on 2/4/24.
//

import SwiftUI

struct MainTabBar: View {
    
    @Environment(WorkoutSessionModel.self) var workoutSession
    
    
    var body: some View {
        @State var selectedTab = workoutSession.selectedTab
        TabView(selection: $selectedTab) {
            RoutinesListView()
                .tabItem { Label("Routines", systemImage: "book") }
                .tag(0)
            ProfileView()
                .tabItem { Label("Profile", systemImage: "person") }
                .tag(1)
            ExerciseListView(addedExercises: .constant([Exercise]()), accessedFromWorkout: .constant(false))
                .tabItem { Label("Exercises", systemImage: "list.bullet") }
                .tag(2)
            if workoutSession.sessionStarted && workoutSession.startedWorkout != nil{
                ActiveWorkoutView(workout: workoutSession.startedWorkout!)

                    .tabItem { Label("Session", systemImage: "dumbbell") }
                    .tag(3)
            } else {
                Text("Go Start a workout")
                    .tabItem { Label("Session", systemImage: "dumbbell") }
                    .tag(3)
            }
        }
    }
}

//#Preview {
//    MainTabBar()
//}
