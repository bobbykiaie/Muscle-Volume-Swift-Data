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
  
    
    var body: some View {
        Form {
            Group {
                TextField("Name", text: $routine.name)
              Text("SCone")

            }
        }
    }
}

#Preview {
    AddRoutineView(routine: Routine(name: "scone"))
}
