//
//  ActiveWorkoutView.swift
//  Muscle Volume
//
//  Created by Babak Kiaie on 1/22/24.
//

import SwiftUI
import SwiftData





struct ActiveWorkoutView: View {
    @Environment(WorkoutSessionModel.self) var workoutSession
    @Bindable var workout: Workout
   
    @State var musclesWorked: [String : Int] = [:]
    
    private let gridSpacing: CGFloat = 10
    private func updateMusclesWorked(for exercise: Exercise) {
        musclesWorked[exercise.primaryMuscle.rawValue, default: 0] += 1
     }
    var body: some View {
        let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: gridSpacing), count: 3)
        NavigationStack{
            ScrollView{
                VStack(alignment: .leading) {
                    Text("Muscles Worked:")
                        .font(.headline)
                    LazyVGrid(columns: columns, alignment: .center, spacing: gridSpacing) {
                        
                        ForEach(musclesWorked.map { ($0.key, $0.value) }, id: \.0) { key, value in
                            MuscleWorkedIcon(muscle: key, setNumber: value)
                               }
                    }
                          
                    
                        }
           
                ForEach(workout.exercises) {
                    exercise in
                 
                    ActiveWorkoutExerciseRow(exercise: exercise) {
                        musclesWorked[exercise.primaryMuscle.rawValue]! += 1
                    }
                }
            
            }
            .onAppear(perform: {
                print(workout.musclesWorked)
                for muscles in workout.musclesWorked {
                    musclesWorked[muscles.rawValue] = 0
                }
                print(musclesWorked)
            })
            .padding(.bottom, 65)
            .navigationTitle(workout.name)
                .toolbar(content: {
                    Button("End Workout") {
                        workoutSession.selectedTab = 0
                        workoutSession.sessionStarted = false
                        workoutSession.startedWorkout = nil
                        
                    }
                })
//                .overlay(alignment: .bottom) {
//                    VStack {
//                        ScrollView {
//                        
//                        }
//                    }.background(.white)
//                }
        }
        
    }
}

#Preview {
    do {
      
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Workout.self, configurations: config)
        var workout = Workout(name: "Full Body")
        var exerciseSample = Exercise(name: "Dip", primaryMuscle: .abs)
        workout.exercises.append(exerciseSample)
        container.mainContext.insert(workout)
        
        return ActiveWorkoutView(workout: workout)
            .modelContainer(container)
    }
    catch {
        return Text("Failed to create container")
    }
}
