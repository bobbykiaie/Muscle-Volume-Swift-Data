import SwiftUI

struct MuscleWorkedIcon: View {
    var muscle: String
    var setNumber: Float

    var formattedSetNumber: String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0 // No minimum fraction digits
        formatter.maximumFractionDigits = 1 // Max 1 digit after decimal point for non-whole numbers
        return formatter.string(from: NSNumber(value: setNumber)) ?? "\(setNumber)"
    }

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(.blue.opacity(0.4))
                    .frame(width: 30, height: 30)
                    
                Text(formattedSetNumber)
                    .foregroundStyle(.white)
                    .font(.subheadline)
                    .fontWeight(.bold)
            }
            Text(muscle)
                .font(.caption)
                .foregroundStyle(.secondary)
                .fontWeight(.semibold)
                
        }
    }
}

// Preview provider for SwiftUI Canvas
struct MuscleWorkedIcon_Previews: PreviewProvider {
    static var previews: some View {
        MuscleWorkedIcon(muscle: "Back", setNumber: 1.0)
    }
}
