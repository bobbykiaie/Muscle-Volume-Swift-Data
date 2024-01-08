//
//  ExerciseView.swift
//  Muscle Volume
//
//  Created by Babak Kiaie on 1/6/24.
//

import SwiftUI
import SwiftData




struct ExerciseView: View {
    @Bindable var exercise: Exercise
  

    var body: some View {
        Form {
            Section("Muscle Groups") {
                Picker("Primary Muscle", selection: $exercise.primaryMuscle) {
                    ForEach(MuscleGroup.allCases, id: \.self) { muscle in
                        Text(muscle.rawValue).tag(muscle.rawValue)
                    }
                }
            }
        }
    }
}


//#Preview {
//    ExerciseView(exercise: Exercise(name: "scone", primaryMuscle: MuscleGroup.abs))
//}
