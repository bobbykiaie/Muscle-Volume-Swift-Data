//
//  Muscle_VolumeApp.swift
//  Muscle Volume
//
//  Created by Babak Kiaie on 12/30/23.
//

import SwiftUI
import SwiftData

// In Muscle_VolumeApp.swift
@main

struct Muscle_VolumeApp: App {
 

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Routine.self, Exercise.self])
    }
}
