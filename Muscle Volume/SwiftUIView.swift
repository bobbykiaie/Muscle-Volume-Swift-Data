//
//  SwiftUIView.swift
//  Muscle Volume
//
//  Created by Babak Kiaie on 1/16/24.
//

import SwiftUI

struct SelectedExerciseButton: View {
    
    var selectedExercise: Exercise


    
    var body: some View {
        ZStack{
            Button(selectedExercise.name) {
                print("Scone")
            }
            .buttonBorderShape(.capsule)
            
        }.buttonStyle(.bordered)
            .tint(.green)
    }
}

#Preview {
    
    SelectedExerciseButton(selectedExercise: Exercise(name: "Bench Press", primaryMuscle: .chest, secondaryMuscle: .triceps))
}
