//
//  ContentView.swift
//  Muscle Volume
//
//  Created by Babak Kiaie on 12/30/23.
//

import SwiftUI
import SwiftData



struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var exercises: [Exercise]
    @Environment(User.self) private var user

    @State var tab: Int = 0
    
    var body: some View {
      
        TabView(selection: $tab) {
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
            } else {
                Text("Go Start a workout")
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
