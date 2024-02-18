//
//  WorkoutEditView.swift
//  Muscle Volume
//
//  Created by Babak Kiaie on 1/8/24.
//

import SwiftUI
import SwiftData



struct WorkoutEditView: View {
    
    @Bindable var workout: Workout
    @State var exerciseListPresented: Bool = false

    @Binding var selectedTab: Int?
    @Environment(WorkoutSessionModel.self) var workoutSession
   
    
    var body: some View {
      
        VStack{
            Form{
                Section("About"){
                    TextField("Workout Name", text: $workout.name)
                                    }
                Section("Exercises") {
                    List{
                        ForEach(workout.exercises) {
                            exercise in
                            NavigationLink(exercise.name) {
                                ExerciseView(exercise: exercise)
                            }
                        }.onDelete { indexset in
                            workout.exercises.remove(atOffsets: indexset)
                        }
                    }
                }
               
            }
            HStack {
                Button("Add Exercise") {
                    exerciseListPresented.toggle()
                }.buttonStyle(.borderedProminent)
                    .sheet(isPresented: $exerciseListPresented) {
                        ExerciseListView(addedExercises: $workout.exercises, accessedFromWorkout: $exerciseListPresented ).onDisappear(perform: {
                            print("Disappeared")
                        
                        })
                    }
                Button("Start Workout") {
                    workoutSession.sessionStarted = true
                    workoutSession.startedWorkout = workout
                    workoutSession.selectedTab = 3
                }.buttonStyle(.borderedProminent).tint(.green)
//                    .sheet(isPresented: $user.workoutStarted) {
//                       Text("Workout Started")
//                    }
            }
        }
        .navigationTitle(workout.name)
    }
    
}

#Preview {
   
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Workout.self, configurations: config)
        var workout = Workout(name: "Full Body")
        var exerciseSample = [Exercise(name: "Dip", primaryMuscle: .abs), Exercise(name: "Dip", primaryMuscle: .abs), Exercise(name: "Dip", primaryMuscle: .abs)]
        workout.exercises = exerciseSample
        container.mainContext.insert(workout)
        
        return WorkoutEditView(workout: workout, selectedTab: .constant(0))
            .modelContainer(container)
    }
    catch {
        return Text("Failed to create container")
    }
}
