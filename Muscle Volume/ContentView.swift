//
//  ContentView.swift
//  Muscle Volume
//
//  Created by Babak Kiaie on 12/30/23.
//

import SwiftUI
import SwiftData

@Observable class User {
    var workoutStarted: Bool = false
    var workout: Workout?
    var selectedTab: Int = 0
}

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var exercises: [Exercise]
    @Environment(User.self) var user
    
  
    
    var body: some View {
        @State var selectedTab = user.selectedTab
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
            if user.workoutStarted {
                ActiveWorkoutView(workout: user.workout!)
                    .tabItem { Label("Session", systemImage: "dumbbell") }
                    .tag(3)
            }
        }
       
    
    }


}

//#Preview {
//    
//    ContentView( user: User.init()).environment(User)
//        .modelContainer(for: Routine.self, inMemory: true)
//}
