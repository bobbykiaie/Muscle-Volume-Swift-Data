import SwiftUI

struct MainTabBar: View {
    @Environment(WorkoutSessionModel.self) var workoutSession // Assuming EnvironmentObject is used
    @State private var selectedTab: Int = 0

    var body: some View {
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
            Group {
                if workoutSession.sessionStarted && workoutSession.startedWorkout != nil {
                    ActiveWorkoutView(workout: workoutSession.startedWorkout!)
                } else {
                    Text("Go Start a workout")
                }
            }
            .tabItem { Label("Session", systemImage: "dumbbell") }
            .tag(3)
        }
        .onChange(of: workoutSession.selectedTab) {
            selectedTab = workoutSession.selectedTab
        }
        
    }
}
