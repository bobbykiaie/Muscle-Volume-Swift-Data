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
    @Binding var addedExercises: [Exercise]
    @Binding var accessedFromWorkout: Bool
    @State var selectedColor: UIColor = .red
    
    
    
    var body: some View {
        let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
        NavigationStack {
            if addedExercises.isEmpty == false {
                Group {
                    LazyVGrid(columns: columns, alignment: .leading, spacing: 10) {
                        
                        ForEach(Array(addedExercises.enumerated()), id: \.element) {
                            index, exercise in
                           
                            ZStack{
                                Button(exercise.name) {
                                    addedExercises.remove(at: index)
                                }
                                .buttonBorderShape(.roundedRectangle)
                                .font(.caption)
                                
                            }.buttonStyle(.bordered)
                                .tint(.green)
                            }
                        
                    }
                    .padding(.leading)
                }
               
            }
            VStack {
            
                List {
                    ForEach(exercises) {
                        exercise in
                        HStack{
                            NavigationLink(value: exercise) {
                                Text(exercise.name)
                            }
                            Button {
                                addedExercises.append(exercise)
                                
                            } label: {
                                if accessedFromWorkout {
                                    ZStack{
                                        if exercise.exerciseSelected == true {
                                            Image(systemName: "plus").background(in: .circle).foregroundStyle(Color(uiColor: .green))
                                        } else {
                                            Image(systemName: "plus").background(in: .circle).foregroundStyle(Color(uiColor: .red))
                                        }
                                    }
                                }
                            }.buttonStyle(.plain)
                        }
                    }.onDelete(perform: { indexSet in
                        deleteExercises(at: indexSet)
                    })
                }
                .onAppear(perform: addExercsies)
                .navigationDestination(for: Exercise.self) { exercise in
                    ExerciseView(exercise: exercise)
                }
                .navigationTitle("Exercises")
                .toolbar {
                    if accessedFromWorkout {
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
//#Preview {
//    @Binding var addedExercise: [Exercise]
//    ExerciseListView(addedExercises: $addedExercise, accessedFromWorkout: .constant(false))
////    do {
////        @Binding(projected) var addedExercises: [Exercise]
////        let config = ModelConfiguration(isStoredInMemoryOnly: true)
////        let container = try ModelContainer(for: Exercise.self, configurations: config)
////        for exercise in defaultExercises {
////            container.mainContext.insert(exercise)
////        }
////       
////        
////        return ExerciseListView(addedExercises: addedExercises, accessedFromWorkout: .constant(true))
////            .modelContainer(container)
////    }
////    catch {
////        return Text("Failed to create container")
////    }
//}

