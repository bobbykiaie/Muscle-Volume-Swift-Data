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
    @State private var numberOfSets: Int = 1
    @State var offset: CGSize = .zero
    @State var deleteOffset: CGSize = .zero
    var upMuscleSet: () -> Void

        var body: some View {
            VStack(alignment: .leading){
                Text(exercise.name).font(.headline)
                HStack(alignment: .center, spacing: 45) {
                    Text("Set")
                    Text("Reps")
                    Text("Weight")
                    Text("RPE")
                }.padding(.leading, 5)
                
                    ForEach(1...numberOfSets, id:\.self) { set in
                        ExerciseInputRow(exercise: exercise) {
                            guard numberOfSets > 1 else {
                                return
                            }
                            numberOfSets -= 1
                        }
        
                    }
    
                HStack {
                    Spacer()
                    Button {
                        numberOfSets += 1
                        upMuscleSet()
                    } label: {
                        Image(systemName: "plus")
                }.buttonStyle(.bordered)
                }
                Spacer()
                
            }
            .padding(.horizontal, 25)
        }
    }
    

#Preview {
    do {
        
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Exercise.self, configurations: config)
        var exerciseSample = Exercise(name: "Dip", primaryMuscle: .triceps, set: 4)
        container.mainContext.insert(exerciseSample)
        
        return ActiveWorkoutExerciseRow(exercise: exerciseSample, upMuscleSet: {})
            .modelContainer(container)
    }
    catch {
        return Text("Failed to create container")
    }
}
