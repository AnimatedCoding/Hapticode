//
//  UIKitHaptics.swift
//  Hapticode
//
//  Created by Noah on 7/13/26.
//

import SwiftUI

#if os(macOS)
#else
struct UIKitImpactHaptics: View {
    let impactHaptics = [
        UIKitImpactHaptic(name: "Soft", haptic: .soft, docURL: URL(string: "https://developer.apple.com/documentation/uikit/uiimpactfeedbackgenerator/feedbackstyle/soft")!),
        UIKitImpactHaptic(name: "Light", haptic: .light, docURL: URL(string: "https://developer.apple.com/documentation/uikit/uiimpactfeedbackgenerator/feedbackstyle/light")!),
        UIKitImpactHaptic(name: "Medium", haptic: .medium, docURL: URL(string: "https://developer.apple.com/documentation/uikit/uiimpactfeedbackgenerator/feedbackstyle/medium")!),
        UIKitImpactHaptic(name: "Rigid", haptic: .rigid, docURL: URL(string: "https://developer.apple.com/documentation/uikit/uiimpactfeedbackgenerator/feedbackstyle/rigid")!),
        UIKitImpactHaptic(name: "Heavy", haptic: .heavy, docURL: URL(string: "https://developer.apple.com/documentation/uikit/uiimpactfeedbackgenerator/feedbackstyle/heavy")!),
    ]
    @State private var info = false
    var body: some View {
        Section {
            ForEach(impactHaptics) { haptic in
                UIKitImpactHapticRow(haptic: haptic)
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
                    InfoSheet(haptic: HapticsInfo(title: "These are haptics you can get with UIImpactFeedbackGenerator. Here's an example:", example:
                        """
                        struct ContentView: View {
                            var body: some View {
                                Button("Play .light") {
                                    let impactGenerator = UIImpactFeedbackGenerator(style: .light)
                                    impactGenerator.prepare()
                                    impactGenerator.impactOccurred()
                                }
                            }
                        }
                        """,
                        docs: URL(string: "https://developer.apple.com/documentation/uikit/uiimpactfeedbackgenerator")!))
                })
            }
        }
    }
}

struct UIKitImpactHaptic: Haptic {
    var id = UUID()
    var name: String
    var haptic: UIImpactFeedbackGenerator.FeedbackStyle
    var docURL: URL
    var platforms: [Platform] = []
}

extension UIImpactFeedbackGenerator.FeedbackStyle: @retroactive Decodable {}
extension UIImpactFeedbackGenerator.FeedbackStyle: @retroactive Encodable {}

struct UIKitImpactHapticRow: View {
    @State private var info = false
    let haptic: UIKitImpactHaptic
    
    init(haptic: UIKitImpactHaptic) {
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
        UIKitImpactHaptics()
    }
}
#endif
