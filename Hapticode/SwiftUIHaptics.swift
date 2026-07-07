//
//  SwiftUIHaptics.swift
//  Hapticode
//
//  Created by Noah on 7/5/26.
//

import SwiftUI

struct SwiftUIHaptics: View {
    private let swiftUIHaptics: [(name: String, haptic: SensoryFeedback)] = [
        ("Alignment", .alignment),
        ("Decrease", .decrease),
        ("Error", .error),
        ("Impact", .impact),
        ("Increase", .increase),
        ("Level change", .levelChange),
        ("Path complete", .pathComplete),
        ("Selection", .selection),
        ("Start", .start),
        ("Stop", .stop),
        ("Success", .success),
        ("Warning", .warning),
        ("Impact (rigid)", .impact(flexibility: .rigid)),
        ("Impact (soft)", .impact(flexibility: .soft)),
        ("Impact (solid)", .impact(flexibility: .solid)),
        ("Press (button)", .press(.button)),
        ("Press (buttonIconOnly)", .press(.buttonIconOnly)),
        ("Press (slider)", .press(.slider)),
        ("Press (tab)", .press(.tab)),
        ("Press (toggle)", .press(.toggle)),
        ("Release (slider)", .release(.slider)),
        ("Selection (maximum)", .selection(.maximum)),
        ("Selection (minimum)", .selection(.minimum)),
        ("Selection (off)", .selection(.off)),
        ("Selection (on)", .selection(.on)),
    ]
    
    @State private var clickss = 0
    @State private var info = false
    var body: some View {
        Section {
            ForEach(swiftUIHaptics, id: \.name) { haptic in
                SwiftUIHapticsListRow(haptic: haptic)
            }
        } header: {
            HStack {
                Text("SwiftUI sensory feedback")
                Spacer()
//                Button(action: {
//                    info = true
//                }) {
//                    Image(systemName: "info")
//                }
//                .sheet(isPresented: $info, content: {
//                    SwiftUIHapticsInfo()
//                })
            }
        }
    }
}

struct SwiftUIHapticsInfo: View {
    var modifier: AttributedString {
        var result = AttributedString(".sensoryFeedback(T##feedback: SensoryFeedback##SensoryFeedback, trigger: T##Equatable)")
        result.foregroundColor = .white
        result.backgroundColor = .gray
        result.font = .system(.body, design: .monospaced)
        return result
    }
    
    var body: some View {
        Text("These are haptics you can get with the " + modifier)
        Text("Example:")
        ScrollView(.horizontal) {
            Text(
"""
struct SwiftUIHapticsListRow: View {
    @State var haptic: (name: String, haptic: SensoryFeedback)
    @State private var clicks = 0
    var body: some View {
        Button(haptic.name) {
            clicks += 1
        }
        .sensoryFeedback(haptic.haptic, trigger: clicks)
    }
}
""")
        }
        .scrollIndicators(.hidden)
        .padding()
        .foregroundStyle(.foreground)
    }
}

struct SwiftUIHapticsListRow: View {
    @State var haptic: (name: String, haptic: SensoryFeedback)
    @State private var clicks = 0
    var body: some View {
        Button(haptic.name) {
            clicks += 1
        }
        .contentShape(Rectangle())
        .sensoryFeedback(haptic.haptic, trigger: clicks)
    }
}

#Preview {
    List {
        SwiftUIHaptics()
    }
}
