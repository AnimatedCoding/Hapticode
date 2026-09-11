//
//  UIKitHaptics.swift
//  Hapticode
//
//  Created by Noah on 7/13/26.
//

import SwiftUI

#if os(macOS)
#else
struct UIKitSelectionHaptics: View {
    var feedback = UISelectionFeedbackGenerator()
    @State private var info = false
    @State private var x = 0.5
    @State private var y = 0.5
    var body: some View {
        Section {
            Button("Play", action: {
                feedback.prepare()
                if #available(iOS 17.5, *) {
                    feedback.selectionChanged(at: CGPoint(x: x, y: y))
                } else {
                    feedback.selectionChanged()
                }
            })
            Stepper("x value: \(x.description)", value: $x)
            Stepper("y value: \(y.description)", value: $y)
            Text("I don't realy see any difference when you change the values here")
                .font(.caption2)
        } header: {
            HStack {
                Text("UIKit Selection Feedback Generator")
                Spacer()
                Button(action: {
                    info = true
                }) {
                    Image(systemName: "info")
                }
                .sheet(isPresented: $info, content: {
                    InfoSheet(haptic: HapticsInfo(title: "These are haptics you can get with UISelectionFeedbackGenerator. There is something where you give it the coordinates of the selection and a UIView, but I don't quite know what that accomplished. Here's an example of the way without coordinates:", example:
                        """
                        struct ContentView: View {
                            var feedback = UISelectionFeedbackGenerator()
                            var body: some View {
                                Button("Play") {
                                    feedback.prepare()
                                    feedback.selectionChanged(at: CGPoint(x: 0.5, y: 0.5))
                                }
                            }
                        }
                        """,
                        docs: URL(string: "https://developer.apple.com/documentation/uikit/uiselectionfeedbackgenerator")!))
                })
            }
        }
    }
}

struct UIKitSelectionHaptic: Haptic {
    var id = UUID()
    var name: String
    var x: Double
    var y: Double
    var docURL: URL
    var platforms: [Platform] = []
}

#Preview {
    List {
        UIKitNotificationHaptics()
    }
}
#endif
