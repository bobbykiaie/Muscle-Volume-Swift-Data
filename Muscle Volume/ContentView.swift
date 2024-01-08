//
//  ContentView.swift
//  Muscle Volume
//
//  Created by Babak Kiaie on 12/30/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var exercises: [Exercise]
    
    var body: some View {
        TabView {
            RoutinesListView()
                .tabItem { Label("Routines", systemImage: "book") }
            ProfileView()
                .tabItem { Label("Profile", systemImage: "person") }
            ExerciseListView()
                .tabItem { Label("Exercises", systemImage: "list.bullet") }
        }
       
    
    }


}

#Preview {
    ContentView()
        .modelContainer(for: Routine.self, inMemory: true)
}
