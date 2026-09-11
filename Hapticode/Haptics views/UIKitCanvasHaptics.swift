//
//  UIKitHaptics.swift
//  Hapticode
//
//  Created by Noah on 7/13/26.
//

import SwiftUI

#if os(macOS)
#else
@available(iOS 17.5, *)
struct UIKitCanvasHaptics: View {
    var feedback = UICanvasFeedbackGenerator()
    @State private var info = false
    @State private var x = 0.5
    @State private var y = 0.5
    var body: some View {
        Section {
//            Button("Play", action: {
//                feedback.prepare()
//                if #available(iOS 17.5, *) {
//                    feedback.selectionChanged(at: CGPoint(x: x, y: y))
//                } else {
//                    feedback.selectionChanged()
//                }
//            })
//            Stepper("x value", value: $x)
//            Stepper("y value", value: $y)
//            ForEach(impactHaptics) { haptic in // implement saved here?
//                UIKitSelectionHapticRow(haptic: haptic)
//            }
            Text("This will be impleented soon")
        } header: {
            HStack {
                Text("UIKit Canvas Feedback Generator")
                Spacer()
                Button(action: {
                    info = true
                }) {
                    Image(systemName: "info")
                }
                .sheet(isPresented: $info, content: {
                    InfoSheet(
                        haptic: HapticsInfo(title: "These are haptics you can get with UICanvasFeedbackGenerator. They are for drawing events and will play tactile feedback on Apple Pencil Pro. Here's an example:",
                                            example: """
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
                                            docs: URL(string: "https://developer.apple.com/documentation/uikit/uiselectionfeedbackgenerator")!)
                    )
                })
            }
        }
    }
}

struct UIKitCanvasHaptic: Haptic {
    var id = UUID()
    var name: String
    var x: Double
    var y: Double
    var docURL: URL
    var platforms: [Platform] = []
}

//UICanvasFeedbackGenerator.responds(to: )

#Preview {
    List {
        UIKitNotificationHaptics()
    }
}
#endif
