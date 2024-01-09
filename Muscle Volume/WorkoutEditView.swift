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
            Button("Add Exercise") {
                exerciseListPresented.toggle()
            }.buttonStyle(.borderedProminent)
                .sheet(isPresented: $exerciseListPresented) {
                    ExerciseListView(addedExercises: $workout.exercises)
                }
            
        }
        .navigationTitle(workout.name)
    }
    
}

#Preview {
    WorkoutEditView(workout: Workout(name: "Scone"))
}
