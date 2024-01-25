//
//  ActiveWorkoutView.swift
//  Muscle Volume
//
//  Created by Babak Kiaie on 1/22/24.
//

import SwiftUI
import SwiftData

struct ActiveWorkoutView: View {
    
    @Bindable var workout: Workout
    var body: some View {
        NavigationStack{
            ScrollView{
                ForEach(workout.exercises) {
                    exercise in
                    ActiveWorkoutExerciseRow(exercise: exercise)
                }
            
            }.navigationTitle(workout.name)
        }
        
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Workout.self, configurations: config)
        var workout = Workout(name: "Full Body")
        var exerciseSample = Exercise(name: "Dip", primaryMuscle: .abs)
        workout.exercises.append(exerciseSample)
        container.mainContext.insert(workout)
        
        return ActiveWorkoutView(workout: workout)
            .modelContainer(container)
    }
    catch {
        return Text("Failed to create container")
    }
}
