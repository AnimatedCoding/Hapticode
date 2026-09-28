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
    private var haptics: [ComboTrigger] = []
	var hapticList: [ComboTrigger] {
		get {
			haptics.sorted(by: { $0.order < $1.order })
		}
		set {
			haptics = newValue
		}
	}
    init(
        name: String
    ) {
        self.name = name
    }
}

@available(iOS 17.5, *)
@Model
class ComboTrigger { // Haptic or wait
	var order: Int
    var delay: Int
	var haptic: HapticContainer
    init(
		order: Int,
        delay: Int,
		haptic: ComboTrigger.HapticContainer
    ) {
		self.order = order
		self.delay = delay
		self.haptic = haptic
    }
    enum HapticContainer: Codable {
        case coreHaptic(CoreHaptic)
        case swiftUI(SwiftUIFeedback)
        case UIKitCanvasHaptic(UIKitCanvasHaptic)
		case UIKitImpactHaptic(UIKitImpactHaptic)
        case UIKitNotification(UIKitNotificationHaptic)
		case UIKitSelectionHaptic(UIKitSelectionHaptic)
    }
}
