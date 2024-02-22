//
//  ExerciseRow.swift
//  Muscle Volume
//
//  Created by Babak Kiaie on 2/20/24.
//

import SwiftUI

struct ExerciseRow: View {
    
    var exercise: Exercise
    @Binding var addedExercises: [Exercise]
    @Binding var accessedFromWorkout: Bool
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                NavigationLink(value: exercise) {
                    Text(exercise.name)
                }.foregroundStyle(.primary).fontWeight(.semibold)
                Text(exercise.primaryMuscle.rawValue)
                    .foregroundStyle(.secondary)
            }
          
            Spacer()
            Button {
                if addedExercises.contains(exercise) == false {
                    addedExercises.append(exercise)
                } else {
                    if let removeIndex = addedExercises.firstIndex(of: exercise) {
                        addedExercises.remove(at: removeIndex)
                    }
                
                }
                    
                
                
            } label: {
                if accessedFromWorkout {
                    ZStack{
                        if exercise.exerciseSelected == true {
                            Image(systemName: "checkmark")
                        } else {
                            Image(systemName: "plus")
                        }
                    }
                }
            }.buttonStyle(.bordered)
                .tint(addedExercises.contains(exercise)  ? .green : .secondary)
        }
    }
}


