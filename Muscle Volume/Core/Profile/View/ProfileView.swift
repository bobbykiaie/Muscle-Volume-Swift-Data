//
//  ProfileView.swift
//  Muscle Volume
//
//  Created by Babak Kiaie on 1/5/24.
//

import SwiftUI

struct ProfileView: View {
    @Environment(WorkoutSessionModel.self) var workoutSession
    
    var body: some View {
        VStack {
            Text("Profile View")
            Text("Workout in session: \(workoutSession.sessionStarted.description)")
        }
        
    }
}

#Preview {
    ProfileView()
}
