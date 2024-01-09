//
//  Routines.swift
//  Muscle Volume
//
//  Created by Babak Kiaie on 1/5/24.
//

import SwiftUI
import SwiftData

struct RoutinesListView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query private var routines: [Routine]
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(routines) {
                    routine in
                    NavigationLink(routine.name, value: routine)
                    
                  
                }
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
}

#Preview {
    RoutinesListView()
}
