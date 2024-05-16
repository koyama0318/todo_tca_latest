//
//  Item.swift
//  todo_tca_latest
//
//  Created by koyama on 2024/05/16.
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
