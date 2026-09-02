//
//  Legacy-iOS-16-View.swift
//  Hapticode
//
//  Created by Noah on 7/19/26.
//

import SwiftUI

#if os(macOS)
#else
struct Legacy_iOS_16_View: View {
    var body: some View {
        List {
            UIKitImpactHaptics()
            UIKitNotificationHaptics()
            UIKitSelectionHaptics()
        }
    }
}

#Preview {
    Legacy_iOS_16_View()
}
#endif
