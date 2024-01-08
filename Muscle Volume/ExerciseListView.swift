//
//  ExerciseListView.swift
//  Muscle Volume
//
//  Created by Babak Kiaie on 1/6/24.
//

import SwiftUI
import SwiftData

struct ExerciseListView: View {
    @Environment(\.modelContext) var modelContext
    @Query var exercises: [Exercise]
    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(exercises) {
                    exercise in
                    NavigationLink(value: exercise) {
                        Text(exercise.name)
                    }
                }.onDelete(perform: { indexSet in
                    deleteExercises(at: indexSet)
                })
                
            }.onAppear(perform: addExercsies)
                .navigationDestination(for: Exercise.self) { exercise in
                    ExerciseView(exercise: exercise)
                }
                .navigationTitle("Exercises")
                .toolbar {
                    Button("Delete all"){
                        print("Deleting")
                        do {
                            try modelContext.delete(model: Exercise.self)
                        } catch {
                            print("Nothing to delete")
                        }
                       
                    }
                }
        }
    }
    func deleteExercises(at offsets: IndexSet) {
        for index in offsets {
            let exerciseToDelete = exercises[index]
            modelContext.delete(exerciseToDelete)
        }

        do {
            try modelContext.save()
        } catch {
            print("Error saving context after deletion: \(error)")
        }
    }

    
    func addExercsies() {
        print("startingm add exercises")
        if exercises.isEmpty {
            for exercise in defaultExercises {
                modelContext.insert(exercise)
            }
            
            do {
                try modelContext.save()
            } catch {
                // Handle the error appropriately.
                print("Error saving context: \(error)")
            }
        }
    }
}
//
//#Preview {
//    ExerciseListView()
//}
