//
//  AddRoutineView.swift
//  Muscle Volume
//
//  Created by Babak Kiaie on 1/5/24.
//

import SwiftUI
import SwiftData


struct AddRoutineView: View {
    @Bindable var routine: Routine
    @Binding var path: NavigationPath
    @State private var selectedWorkout: Workout?  // State to keep track of selected workout
   
    var body: some View {
        
        VStack {
            Form {
                Group {
                    TextField("Name", text: $routine.name)
                }
                Section("Workouts") {
                    List {
                        if routine.workouts.isEmpty {
                            Text("Add a workout")
                        } else {
                            ForEach(routine.workouts) { workout in
                                if workout.name != "" {
                                   
                                    Button(workout.name) {
                                        selectedWorkout = workout
                                        path.append(workout)
                                    }
                                }
                               
                            }
                        }
                    }
                    Button("Add Workout") {
                       addWorkout()
                    }.buttonStyle(.borderedProminent)
                }
            }
        }
        .navigationTitle(routine.name)
        .navigationDestination(for: Workout.self) { workout in
            WorkoutEditView(workout: workout)
        }
    }

    func addWorkout() {
        print(routine)
        let workout = Workout()
        routine.workouts.append(workout)
        selectedWorkout = workout
        path.append(workout)
    }
}


#Preview {
    AddRoutineView(routine: Routine(name: "scone"), path: .constant(NavigationPath()))
}
