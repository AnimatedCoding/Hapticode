//
//  SwiftUIHaptics.swift
//  Hapticode
//
//  Created by Noah on 7/5/26.
//

import SwiftUI

@available(iOS 17.5, macOS 14.5, *)
struct SwiftUIHaptics: View {
    private let swiftUIHaptics: [SwiftUIFeedback]
    init() {
        if #available(iOS 26, macOS 26, *) {
            swiftUIHaptics = [
                SwiftUIFeedback(name: "Alignment", haptic: .alignment, docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/alignment")!, platforms: [.iOS, .macOS]),
                SwiftUIFeedback(name: "Decrease", haptic: .decrease, docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/decrease")!, platforms: [.watchOS, .visionOS]),
                SwiftUIFeedback(name: "Error", haptic: .error, docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/error")!, platforms: [.iOS, .watchOS]),
                SwiftUIFeedback(name: "Impact", haptic: .impact, docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/impact")!, platforms: [.iOS, .watchOS]),
                SwiftUIFeedback(name: "Increase", haptic: .increase, docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/increase")!, platforms: [.watchOS, .visionOS]),
                SwiftUIFeedback(name: "Level change", haptic: .levelChange, docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/levelchange")!, platforms: [.macOS]),
                SwiftUIFeedback(name: "Path complete", haptic: .pathComplete, docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/pathcomplete")!, platforms: [.iOS]),
                SwiftUIFeedback(name: "Selection", haptic: .selection, docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/selection")!, platforms: [.iOS, .watchOS]),
                SwiftUIFeedback(name: "Start", haptic: .start, docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/start")!, platforms: [.watchOS]),
                SwiftUIFeedback(name: "Stop", haptic: .stop, docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/stop")!, platforms: [.watchOS]),
                SwiftUIFeedback(name: "Success", haptic: .success, docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/success")!, platforms: [.iOS, .watchOS]),
                SwiftUIFeedback(name: "Warning", haptic: .warning, docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/warning")!, platforms: [.iOS, .watchOS]),
                SwiftUIFeedback(name: "Impact (rigid)", haptic: .impact(flexibility: .rigid), docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/impact(flexibility:intensity:)")!, platforms: [.iOS, .watchOS]),
                SwiftUIFeedback(name: "Impact (soft)", haptic: .impact(flexibility: .soft), docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/impact(flexibility:intensity:)")!, platforms: [.iOS, .watchOS]),
                SwiftUIFeedback(name: "Impact (solid)", haptic: .impact(flexibility: .solid), docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/impact(flexibility:intensity:)")!, platforms: [.iOS, .watchOS]),
                SwiftUIFeedback(name: "Press (button)", haptic: .press(.button), docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/press(_:)")!, platforms: [.notSpecified]),
                SwiftUIFeedback(name: "Press (buttonIconOnly)", haptic: .press(.buttonIconOnly), docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/press(_:)")!, platforms: [.notSpecified]),
                SwiftUIFeedback(name: "Press (slider)", haptic: .press(.slider), docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/press(_:)")!, platforms: [.notSpecified]),
                SwiftUIFeedback(name: "Press (tab)", haptic: .press(.tab), docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/press(_:)")!, platforms: [.notSpecified]),
                SwiftUIFeedback(name: "Press (toggle)", haptic: .press(.toggle), docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/press(_:)")!, platforms: [.notSpecified]),
                SwiftUIFeedback(name: "Release (slider)", haptic: .release(.slider), docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/release(_:)")!, platforms: [.notSpecified]),
                SwiftUIFeedback(name: "Selection (maximum)", haptic: .selection(.maximum), docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/selection(_:)")!, platforms: [.notSpecified]),
                SwiftUIFeedback(name: "Selection (minimum)", haptic: .selection(.minimum), docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/selection(_:)")!, platforms: [.notSpecified]),
                SwiftUIFeedback(name: "Selection (off)", haptic: .selection(.off), docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/selection(_:)")!, platforms: [.notSpecified]),
                SwiftUIFeedback(name: "Selection (on)", haptic: .selection(.on), docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/selection(_:)")!, platforms: [.notSpecified]),
            ]
        } else {
            swiftUIHaptics = [
//                SwiftUIFeedback(name: "Alignment", haptic: .alignment, docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/alignment")!, platforms: [.iOS, .macOS]),
                SwiftUIFeedback(name: "Decrease", haptic: .decrease, docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/decrease")!, platforms: [.watchOS, .visionOS]),
                SwiftUIFeedback(name: "Error", haptic: .error, docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/error")!, platforms: [.iOS, .watchOS]),
                SwiftUIFeedback(name: "Impact", haptic: .impact, docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/impact")!, platforms: [.iOS, .watchOS]),
                SwiftUIFeedback(name: "Increase", haptic: .increase, docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/increase")!, platforms: [.watchOS, .visionOS]),
                SwiftUIFeedback(name: "Level change", haptic: .levelChange, docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/levelchange")!, platforms: [.macOS]),
                SwiftUIFeedback(name: "Path complete", haptic: .pathComplete, docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/pathcomplete")!, platforms: [.iOS]),
                SwiftUIFeedback(name: "Selection", haptic: .selection, docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/selection")!, platforms: [.iOS, .watchOS]),
                SwiftUIFeedback(name: "Start", haptic: .start, docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/start")!, platforms: [.watchOS]),
                SwiftUIFeedback(name: "Stop", haptic: .stop, docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/stop")!, platforms: [.watchOS]),
                SwiftUIFeedback(name: "Success", haptic: .success, docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/success")!, platforms: [.iOS, .watchOS]),
                SwiftUIFeedback(name: "Warning", haptic: .warning, docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/warning")!, platforms: [.iOS, .watchOS]),
                SwiftUIFeedback(name: "Impact (rigid)", haptic: .impact(flexibility: .rigid), docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/impact(flexibility:intensity:)")!, platforms: [.iOS, .watchOS]),
                SwiftUIFeedback(name: "Impact (soft)", haptic: .impact(flexibility: .soft), docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/impact(flexibility:intensity:)")!, platforms: [.iOS, .watchOS]),
                SwiftUIFeedback(name: "Impact (solid)", haptic: .impact(flexibility: .solid), docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/impact(flexibility:intensity:)")!, platforms: [.iOS, .watchOS]),
            ]
        }
    }
    
    @State private var clickss = 0
    @State private var info = false
    var body: some View {
        Section {
            ForEach(swiftUIHaptics) { haptic in
                SwiftUIHapticsListRow(haptic: haptic)
            }
        } header: {
            HStack {
                Text("SwiftUI sensory feedback")
                Spacer()
                Button(action: {
                    info = true
                }) {
                    Image(systemName: "info")
                }
                .sheet(isPresented: $info, content: {
                    SwiftUIHapticsInfo()
                })
            }
        }
    }
}

@available(iOS 17.0, macOS 14, *)
struct SwiftUIHapticsInfo: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                Text("These are haptics you can get with the .sensoryFeedback(SensoryFeedback, trigger: Equatable). Here's an example:")
                ScrollView(.horizontal) {
                    Text(
"""
struct ContentView: View {
    @State private var clicks = 0
    var body: some View {
        Button(haptic.name) {
            clicks += 1
        }
        .sensoryFeedback(.increase, trigger: clicks)
    }
}
""")
                    .background {
                        RoundedRectangle(cornerSize: CGSize(width: 0.5, height: 0.5), style: .continuous)
                            .foregroundStyle(.background)
                    }
                }
                .scrollIndicators(.hidden)
                Link("Docs", destination: URL(string: "https://developer.apple.com/documentation/swiftui/view/sensoryfeedback(_:trigger:)")!)
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
        #if os(macOS)
        .frame(minHeight: 300)
        #endif
    }
}

@available(iOS 17.0, macOS 14, *)
struct SwiftUIFeedback: Haptic {
    let id = UUID()
    let name: String
    let haptic: SensoryFeedback
    let docURL: URL
    let platforms: [Platform]
}

@available(iOS 17.0, macOS 14, *)
struct SwiftUIHapticsListRow: View {
    @State var haptic: SwiftUIFeedback
    @State private var clicks = 0
    @State private var info = false
    var body: some View {
        RowView(button: { clicks += 1 }, haptic: haptic)
        .sensoryFeedback(haptic.haptic, trigger: clicks)
    }
}

#Preview {
    List {
        if #available(iOS 17.5, macOS 14.5, *) {
            SwiftUIHaptics()
        }
    }
}
