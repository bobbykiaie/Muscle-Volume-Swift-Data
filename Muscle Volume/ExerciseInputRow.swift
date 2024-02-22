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
    var setNumber: Int
    @State private var offset: CGSize = .zero
    var onDelete: () -> Void
    @State private var setComplete = false
    var upTheSet: () -> Void
    var downTheSet: () -> Void
    @State private var reps: String = ""
    @State private var weight: String = ""
    @State private var rpe: String = ""
    @FocusState private var textFieldSelected: theField?
    
    enum theField: Hashable {
        case reps
        case weight
        case rpe
        case cancel
    }
    
    var previousRep: Int {
        var lastRep = exercise.setHistory.last?.reps
        
        return lastRep ?? 0
    }
    
    
    var oneDecimalPlaceFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        return formatter
    }
    
    var rpeFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        formatter.minimum = 0
        formatter.maximum = 10
        return formatter
    }
    
    func dismissKeyoard () {
        textFieldSelected = nil
    }
    var body: some View {
        ZStack{
            Color(.red).frame(height: 30).clipShape(.rect(cornerRadius: 8))
            Text("Delete")
                .font(.caption)
                .foregroundStyle(.white)
                .padding(.leading, 280)
                .offset(x: (abs(offset.width) > 200 ? (offset.width + 80) : 0 ) )
            HStack {
                Button("\(setNumber)") {
                
                }.buttonStyle(.bordered)
                    .foregroundStyle(.primary)
                    .padding(.trailing, 20)
                    

                TextField(String(previousRep), text: $reps)
                    .focused($textFieldSelected, equals: .reps)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)

                TextField("0", text: $weight)
                    .focused($textFieldSelected, equals: .weight)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)

                TextField("0", text: $rpe)
                    .focused($textFieldSelected, equals: .rpe)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)
                
                Spacer()
                Button(action: {
                    // Action to confirm the data entry
                    setComplete.toggle()
                    if setComplete {
                        upTheSet()
                        exercise.setHistory.append(completeSet(reps: Int(reps) ?? 0, weight: Float(weight) ?? 0.0, rpe: Float(rpe) ?? 0.0))
                    } else {
                        downTheSet()
                    }
                    
                }) {
                    Image(systemName: setComplete ? "checkmark.circle.fill" : "checkmark.circle")
                        .foregroundColor(.blue)
                        .font(.system(size: 25))
                    
                    
                }
                
            }
            .background(.background)
            .offset(x: offset.width)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        // Only allow moving left by ensuring the translation width is negative
                        if value.translation.width < 0 {
                            withAnimation(.spring()) {
                                self.offset.width = value.translation.width
                            }
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


