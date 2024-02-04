//
//  ActiveWorkoutExerciseRow.swift
//  Muscle Volume
//
//  Created by Babak Kiaie on 1/24/24.
//

import SwiftUI
import SwiftData

struct ActiveWorkoutExerciseRow: View {
    
        @Bindable var exercise: Exercise

        var body: some View {
            VStack(alignment: .leading){
                Text(exercise.name).font(.headline)
                HStack {
                    VStack(alignment: .leading) {
                        Text("Set")
                        TextField("", value: $exercise.set, formatter: NumberFormatter())
                            .textFieldStyle(.roundedBorder)
                    }
                    VStack(alignment: .leading) {
                        Text("Reps")
                        TextField("", value: $exercise.reps, formatter: NumberFormatter())
                            .textFieldStyle(.roundedBorder)
                    }
                    VStack(alignment: .leading) {
                        Text("Weight")
                        TextField("", value: $exercise.weight, formatter: NumberFormatter())
                            .textFieldStyle(.roundedBorder)
                    }
                    VStack(alignment: .leading) {
                        Text("RPE")
                        TextField("", value: $exercise.rpe, formatter: NumberFormatter())
                            .textFieldStyle(.roundedBorder)
                    }
                    Spacer()
                    Button(action: {
                        // Action to confirm the data entry
                    }) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.blue)
                    }
                }
                .padding()
            }
        }
    }
    

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Exercise.self, configurations: config)
        var exerciseSample = Exercise(name: "Dip", primaryMuscle: .abs)
       
        container.mainContext.insert(exerciseSample)
        
        return ActiveWorkoutExerciseRow(exercise: exerciseSample)
            .modelContainer(container)
    }
    catch {
        return Text("Failed to create container")
    }
}
