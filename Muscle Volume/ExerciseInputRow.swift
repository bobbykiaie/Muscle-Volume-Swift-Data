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
    @State private var setComplete = false
    var upTheSet: () -> Void
    var downTheSet: () -> Void
    

    
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
                    setComplete.toggle()
                    if setComplete {
                        upTheSet()
                    } else {
                        downTheSet()
                    }
                    
                }) {
                    Image(systemName: setComplete ? "checkmark.circle.fill" : "checkmark.circle")
                            .foregroundColor(.blue)
                            .font(.system(size: 25))
                            
                        
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

