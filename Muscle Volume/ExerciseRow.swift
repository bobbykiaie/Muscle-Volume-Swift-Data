//
//  ExerciseRow.swift
//  Muscle Volume
//
//  Created by Babak Kiaie on 2/20/24.
//

import SwiftUI
import SwiftData

struct ExerciseRow: View {
    @Environment(\.modelContext) var modelContext
    var exercise: Exercise
    @Binding var addedExercises: [Exercise]
    @Binding var accessedFromWorkout: Bool
    @State private var offset: CGSize = .zero
    var onSwipe: () -> Void
    
    var body: some View {
            HStack{
                ZStack (alignment: .leading){
                    NavigationLink(value: exercise) {
                        
                    }.opacity(0)
                    VStack(alignment: .leading){
                      
                        Text(exercise.name)
                        .foregroundStyle(.primary).fontWeight(.semibold)
                        Text(exercise.primaryMuscle.rawValue)
                            .foregroundStyle(.secondary)
                    }
                }
         
              
                Spacer()
                if accessedFromWorkout {
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
     
            
        
      
    }



