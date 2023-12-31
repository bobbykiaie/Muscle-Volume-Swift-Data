//
//  Item.swift
//  Muscle Volume
//
//  Created by Babak Kiaie on 12/30/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
