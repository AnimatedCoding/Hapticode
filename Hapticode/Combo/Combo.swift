//
//  Combo.swift
//  Hapticode
//
//  Created by Noah on 8/28/26.
//

import SwiftData

@available(iOS 17.5, *)
@Model
class Combo {
    var name: String
    var haptics: [ComboEvent] = []
    init(
        name: String
    ) {
        self.name = name
    }
}

@available(iOS 17.5, *)
@Model
class ComboEvent { // Haptic or wait
    var order: Int
    init(
        order: Int
    ) {
        self.order = order
    }
    enum HapticContainer: Codable {
        case coreHaptic(CoreHaptic)
        case swiftUI(SwiftUIFeedback)
        case UIKitImpactHaptic(UIKitImpactHaptic)
        case UIKitNotification(UIKitNotificationHaptic)
    }
}
