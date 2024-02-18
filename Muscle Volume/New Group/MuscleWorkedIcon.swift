//
//  MuscleWorkedIcon.swift
//  Muscle Volume
//
//  Created by Babak Kiaie on 2/7/24.
//

import SwiftUI

struct MuscleWorkedIcon: View {
    
    var muscle: String
    var setNumber: Int
    var body: some View {
        VStack{
            ZStack{
                Circle()
                    .fill(Color.red)
                    .frame(width: 30, height: 30)
                Text(String(setNumber))
                    .foregroundStyle(.white)
            }
      
            Text(muscle)
        }
    }
}

#Preview {
    MuscleWorkedIcon(muscle: "back", setNumber: 1)
}
