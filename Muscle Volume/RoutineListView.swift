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
    @State private var path = [Routine]()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(routines) {
                    routine in
                    Text(routine.name)
                }
            }
            .navigationTitle("Routines")
            .navigationDestination(for: Routine.self, destination: AddRoutineView.init)
            .toolbar {
                Button("Add Routine", systemImage: "plus", action: addRoutine)
            }
        }
    }
    func addRoutine() {
        let routine = Routine()
        modelContext.insert(routine)
        path = [routine]
        
    }
}

#Preview {
    RoutinesListView()
}
