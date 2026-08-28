//
//  UIKitHaptics.swift
//  Hapticode
//
//  Created by Noah on 7/13/26.
//

import SwiftUI

#if os(macOS)
#else
struct UIKitHaptics: View {
    let haptics = [
        UIKitHaptic(name: "Light", haptic: .light, docURL: URL(string: "https://developer.apple.com/documentation/uikit/uiimpactfeedbackgenerator/feedbackstyle/light")!),
        UIKitHaptic(name: "Medium", haptic: .medium, docURL: URL(string: "https://developer.apple.com/documentation/uikit/uiimpactfeedbackgenerator/feedbackstyle/medium")!),
        UIKitHaptic(name: "Heavy", haptic: .heavy, docURL: URL(string: "https://developer.apple.com/documentation/uikit/uiimpactfeedbackgenerator/feedbackstyle/heavy")!),
        UIKitHaptic(name: "Rigid", haptic: .rigid, docURL: URL(string: "https://developer.apple.com/documentation/uikit/uiimpactfeedbackgenerator/feedbackstyle/rigid")!),
        UIKitHaptic(name: "Soft", haptic: .soft, docURL: URL(string: "https://developer.apple.com/documentation/uikit/uiimpactfeedbackgenerator/feedbackstyle/soft")!),
    ]
    @State private var info = false
    var body: some View {
        Section {
            ForEach(haptics) { haptic in
                UIKitHapticRow(haptic: haptic)
            }
        } header: {
            HStack {
                Text("UIKit Impact Feedback Generator")
                Spacer()
                Button(action: {
                    info = true
                }) {
                    Image(systemName: "info")
                }
                .sheet(isPresented: $info, content: {
                    UIKitHapticsInfo()
                })
            }
        }
    }
}

struct UIKitHapticsInfo: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStackOldCompatible {
            List {
                Text("These are haptics you can get with UIImpactFeedbackGenerator. Here's an example:")
                ScrollView(.horizontal) {
                    Text(
"""
struct ContentView: View {
    var body: some View {
        Button(haptic.name) {
            let impactGenerator = UIImpactFeedbackGenerator(style: .light)
            impactGenerator.prepare()
            impactGenerator.impactOccurred()
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
                Link("Docs", destination: URL(string: "https://developer.apple.com/documentation/uikit/uiimpactfeedbackgenerator")!)
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

struct UIKitHaptic: Haptic {
    var id = UUID()
    var name: String
    var haptic: UIImpactFeedbackGenerator.FeedbackStyle
    var docURL: URL
    var platforms: [Platform] = []
}

extension UIImpactFeedbackGenerator.FeedbackStyle: @retroactive Decodable {}
extension UIImpactFeedbackGenerator.FeedbackStyle: @retroactive Encodable {}

//UINotificationFeedbackGenerator.FeedbackType.error
//UINotificationFeedbackGenerator.FeedbackType.success
//UINotificationFeedbackGenerator.FeedbackType.warning
//
//UISelectionFeedbackGenerator.selectionChanged()//?
//
//UICanvasFeedbackGenerator.responds(to: )
//
//UIFeedbackGenerator

struct UIKitHapticRow: View {
    @State private var info = false
    let haptic: UIKitHaptic
    
    init(haptic: UIKitHaptic) {
        self.haptic = haptic
    }
    var body: some View {
        RowView(button: {
            let impactGenerator = UIImpactFeedbackGenerator(style: haptic.haptic)
            impactGenerator.prepare()
            impactGenerator.impactOccurred()
        }, haptic: haptic)
    }
}

#Preview {
    List {
        UIKitHaptics()
    }
}
#endif
