//
//  ContentView.swift
//  Hapticode
//
//  Created by Noah on 7/5/26.
//

import SwiftUI
import SwiftData

@available(iOS 16.0, *)
struct ContentView: View {
    @Environment(\.colorScheme) private var colorScheme
    var body: some View {
        NavigationStack {
            List {
#if os(macOS)
				Text("Haptics do not play on macOS")
					.foregroundStyle(.orange)
#endif
                CoreHapticsList()
                if #available(iOS 17.5, *) {
                    SwiftUIHaptics()
                }
#if os(macOS)
#else
                UIKitImpactHaptics()
                UIKitNotificationHaptics()
                UIKitSelectionHaptics()
				if #available(iOS 17.5, *) {
					UIKitCanvasHaptics()
				}
#endif
            }
            .scrollContentBackground(.hidden)
            .background {
                var colors: [Color] {
                    if #available(iOS 18, macOS 15, *) {
                        [
                            colorScheme == .dark ? .blue.mix(with: .black, by: 0.5) : .blue.mix(with: .white, by: 0.95),
                            colorScheme == .dark ? .blue.mix(with: .black, by: 0.95) : .blue.mix(with: .white, by: 0.70)
                            
                        ]
                    } else {
                        []
                    }
                }
                LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    if #available(iOS 16, *) {
        ContentView()
    }
}
