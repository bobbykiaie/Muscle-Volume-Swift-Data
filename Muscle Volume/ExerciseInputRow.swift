//
//  ExerciseInputRow.swift
//  Muscle Volume
//
//  Created by Babak Kiaie on 2/17/24.
//

import SwiftUI
import SwiftData

struct ExerciseInputRow: View {
    
    @Bindable var exercise: Exercise
    @State private var offset: CGSize = .zero
    var onDelete: () -> Void

    
    var body: some View {
        ZStack{
            Color(.red).frame(height: 30).clipShape(.rect(cornerRadius: 8))
           Text("Delete")
                .foregroundStyle(.white)
                .padding(.leading, 280)
                .offset(x: (abs(offset.width) > 200 ? (offset.width + 80) : 0 ) )
            HStack {
                VStack(alignment: .leading) {
                    
                    TextField("", value: $exercise.set, formatter: NumberFormatter())
                        .textFieldStyle(.roundedBorder)
                }
                VStack(alignment: .leading) {
                    
                    TextField("", value: $exercise.reps, formatter: NumberFormatter())
                        .textFieldStyle(.roundedBorder)
                }
                VStack(alignment: .leading) {
                   
                    TextField("", value: $exercise.weight, formatter: NumberFormatter())
                        .textFieldStyle(.roundedBorder)
                }
                VStack(alignment: .leading) {
                    
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
            }.background(.white)
            .offset(x: offset.width)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        
                        withAnimation(.spring()) {
                            self.offset = value.translation
                        
                        }
                    }
                    .onEnded { value in
                        
                            withAnimation(.spring()) {
                                if abs(offset.width) > 100 {
                                 onDelete()
                                }
                                self.offset = .zero
                                
                            }
                        
                     
                    }
            )
        }
        
    }
}

#Preview {
    do {
        
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Exercise.self, configurations: config)
        var exerciseSample = Exercise(name: "Dip", primaryMuscle: .triceps, set: 4)
        container.mainContext.insert(exerciseSample)
        
        return ExerciseInputRow(exercise: exerciseSample, onDelete: {})
            .modelContainer(container)
    }
    catch {
        return Text("Failed to create container")
    }
}
