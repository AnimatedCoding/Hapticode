//
//  UIKitHaptics.swift
//  Hapticode
//
//  Created by Noah on 7/13/26.
//

import SwiftUI

#if os(macOS)
#else
struct UIKitCanvasHaptics: View {
    var feedback = UISelectionFeedbackGenerator()
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
//                Button(action: {
//                    info = true
//                }) {
//                    Image(systemName: "info")
//                }
//                .sheet(isPresented: $info, content: {
//                    UIKitSelectionHapticsInfo()
//                })
            }
        }
    }
}

struct UIKitCanvasHapticsInfo: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStackOldCompatible {
            List {
                Text("These are haptics you can get with UISelectionFeedbackGenerator. Here's an example:")
                ScrollView(.horizontal) {
                    Text(
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
"""
                    )
                    .listRowBackground (
                        RoundedRectangle(cornerSize: CGSize(width: 0.5, height: 0.5), style: .continuous)
                            .foregroundStyle(.background)
                    )
                }
                Text("You can use it with a UI view and have the spacific point where the selection occured, but I haven't done that yet.")
                SafariViewButton(title: "Docs", url: URL(string: "https://developer.apple.com/documentation/uikit/uiselectionfeedbackgenerator")!)
            }
            .listRowSeparator(.hidden)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                    }
                }
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
