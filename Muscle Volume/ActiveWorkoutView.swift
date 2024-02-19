//
//  ActiveWorkoutView.swift
//  Muscle Volume
//
//  Created by Babak Kiaie on 1/22/24.
//

import SwiftUI
import SwiftData


struct ActiveWorkoutView: View {
    @Environment(WorkoutSessionModel.self) var workoutSession
    @Bindable var workout: Workout
    
    var body: some View {
        let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 10), count: 4)
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Muscles Worked:")
                    .font(.headline)
                // Sort the musclesWorked for stable order
                LazyVGrid(columns: columns, alignment: .center, spacing: 10) {
                    // Sort by muscle name to stabilize the order
                    ForEach((workoutSession.startedWorkout?.musclesWorked.sorted(by: { $0.key < $1.key }) ?? []), id: \.0) { muscleName, setCount in
                        MuscleWorkedIcon(muscle: muscleName, setNumber: setCount)
                    }
                }
            }
            .padding(.bottom, 5)
            .navigationTitle(workout.name)
            .toolbar {
                Button("End Workout") {
                    workoutSession.selectedTab = 0
                    workoutSession.sessionStarted = false
                    workoutSession.startedWorkout = nil
                }
            }
            ScrollView {
                ForEach(workout.exercises, id: \.id) { exercise in
                    ActiveWorkoutExerciseRow(exercise: exercise,
                                             upMuscleSet: {
                        // Increment the set count for this exercise's muscle
                        workoutSession.startedWorkout?.incrementSetCount(for: exercise.primaryMuscle)
                    },
                                             downMuscleSet: {
                        // Decrement the set count for this exercise's muscle
                        workoutSession.startedWorkout?.decrementSetCount(for: exercise.primaryMuscle)
                    })
                    
                    
                }
            }
            .onAppear {
                print(workoutSession.startedWorkout?.musclesWorked ?? "No started workout")
            }
        }
    }
}
