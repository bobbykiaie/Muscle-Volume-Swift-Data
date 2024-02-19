//
//  Routines.swift
//  Muscle Volume
//
//  Created by Babak Kiaie on 1/5/24.
//

import SwiftUI
import SwiftData

struct RoutinesListView: View {
    @Environment(WorkoutSessionModel.self) var workoutSession
    @Environment(\.modelContext) var modelContext
    @Query private var routines: [Routine]
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                Text("Workout in session: \(workoutSession.sessionStarted.description)")
                ForEach(routines) {
                    routine in
                    if routine.name != "" {
                        NavigationLink(routine.name, value: routine)
                    }
            
                    
                  
                }.onDelete(perform: { indexSet in
                    deleteRoutine(at: indexSet)
                })
            }
            .navigationTitle("Routines")
            .navigationDestination(for: Routine.self, destination: { routine in
                AddRoutineView(routine: routine, path: $path
                )
            })
            .toolbar {
                Button("Add Routine", systemImage: "plus", action: addRoutine)
            }
        }
    }
    func addRoutine() {
        let routine = Routine()
        
        modelContext.insert(routine)
        path.append(routine)
        
    }
    func deleteRoutine(at offsets: IndexSet) {
        for index in offsets {
            let routineToDelete = routines[index]
            modelContext.delete(routineToDelete)
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Error saving context after deletion: \(error)")
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Routine.self, configurations: config)
        var routine = Routine(name: "Full Body")
       
        container.mainContext.insert(routine)
        
        return RoutinesListView()
            .modelContainer(container)
    }
    catch {
        return Text("Failed to create container")
    }
}
