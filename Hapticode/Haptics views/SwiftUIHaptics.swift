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
                SwiftUIFeedback(name: "Impact (rigid)", haptic: .impactrigid, docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/impact(flexibility:intensity:)")!, platforms: [.iOS, .watchOS]),
                SwiftUIFeedback(name: "Impact (soft)", haptic: .impactsoft, docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/impact(flexibility:intensity:)")!, platforms: [.iOS, .watchOS]),
                SwiftUIFeedback(name: "Impact (solid)", haptic: .impactsolid, docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/impact(flexibility:intensity:)")!, platforms: [.iOS, .watchOS]),
                SwiftUIFeedback(name: "Press (button)", haptic: .pressbutton, docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/press(_:)")!, platforms: [.notSpecified]),
                SwiftUIFeedback(name: "Press (buttonIconOnly)", haptic: .pressbuttonIconOnly, docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/press(_:)")!, platforms: [.notSpecified]),
                SwiftUIFeedback(name: "Press (slider)", haptic: .pressslider, docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/press(_:)")!, platforms: [.notSpecified]),
                SwiftUIFeedback(name: "Press (tab)", haptic: .presstab, docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/press(_:)")!, platforms: [.notSpecified]),
                SwiftUIFeedback(name: "Press (toggle)", haptic: .presstoggle, docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/press(_:)")!, platforms: [.notSpecified]),
                SwiftUIFeedback(name: "Release (slider)", haptic: .releaseslider, docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/release(_:)")!, platforms: [.notSpecified]),
                SwiftUIFeedback(name: "Selection (maximum)", haptic: .selectionmaximum, docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/selection(_:)")!, platforms: [.notSpecified]),
                SwiftUIFeedback(name: "Selection (minimum)", haptic: .selectionminimum, docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/selection(_:)")!, platforms: [.notSpecified]),
                SwiftUIFeedback(name: "Selection (off)", haptic: .selectionoff, docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/selection(_:)")!, platforms: [.notSpecified]),
                SwiftUIFeedback(name: "Selection (on)", haptic: .selectionon, docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/selection(_:)")!, platforms: [.notSpecified]),
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
                SwiftUIFeedback(name: "Impact (rigid)", haptic: .impactrigid, docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/impact(flexibility:intensity:)")!, platforms: [.iOS, .watchOS]),
                SwiftUIFeedback(name: "Impact (soft)", haptic: .impactsoft, docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/impact(flexibility:intensity:)")!, platforms: [.iOS, .watchOS]),
                SwiftUIFeedback(name: "Impact (solid)", haptic: .impactsolid, docURL: URL(string: "https://developer.apple.com/documentation/swiftui/sensoryfeedback/impact(flexibility:intensity:)")!, platforms: [.iOS, .watchOS]),
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
                    InfoSheet(haptic: HapticsInfo(title: "These are haptics you can get with the .sensoryFeedback(SensoryFeedback, trigger: Equatable). Here's an example:", example:
                    """
                    struct ContentView: View {
                        @State private var clicks = 0
                        var body: some View {
                            Button("Increase") {
                                clicks += 1
                            }
                            .sensoryFeedback(.increase, trigger: clicks)
                        }
                    }
                    """,
                    docs: URL(string: "https://developer.apple.com/documentation/swiftui/view/sensoryfeedback(_:trigger:)")!))
                })
            }
        }
    }
}

@available(iOS 17.5, macOS 14, *)
struct SwiftUIFeedback: Haptic {
    var id = UUID()
    var name: String
    var haptic: FeedbackStyle
    var docURL: URL
    var platforms: [Platform]
}

@available(iOS 17.5, *)
enum FeedbackStyle: Codable {
    case alignment, decrease, error, impact, increase, levelChange, pathComplete, selection, start, stop, success, warning, impactrigid, impactsoft, impactsolid
    @available(iOS 26.0, *)
    case pressbutton, pressbuttonIconOnly, pressslider, presstab, presstoggle, releaseslider, selectionmaximum, selectionminimum, selectionoff, selectionon

    var sensoryFeedback: SensoryFeedback {
        if #available(iOS 26, *) {
            switch self {
            case .alignment:
                    .alignment
            case .decrease:
                    .decrease
            case .error:
                    .error
            case .impact:
                    .impact
            case .increase:
                    .increase
            case .levelChange:
                    .levelChange
            case .pathComplete:
                    .pathComplete
            case .selection:
                    .selection
            case .start:
                    .start
            case .stop:
                    .stop
            case .success:
                    .success
            case .warning:
                    .warning
            case .impactrigid:
                    .impact(flexibility: .rigid)
            case .impactsoft:
                    .impact(flexibility: .soft)
            case .impactsolid:
                    .impact(flexibility: .solid)
            case .pressbutton:
                    .press(.button)
            case .pressbuttonIconOnly:
                    .press(.buttonIconOnly)
            case .pressslider:
                    .press(.slider)
            case .presstab:
                    .press(.tab)
            case .presstoggle:
                    .press(.toggle)
            case .releaseslider:
                    .release(.slider)
            case .selectionmaximum:
                    .selection(.maximum)
            case .selectionminimum:
                    .selection(.minimum)
            case .selectionoff:
                    .selection(.off)
            case .selectionon:
                    .selection(.on)
            }
        } else {
            switch self {
            case .alignment:
                    .alignment
            case .decrease:
                    .decrease
            case .error:
                    .error
            case .impact:
                    .impact
            case .increase:
                    .increase
            case .levelChange:
                    .levelChange
            case .pathComplete:
                    .pathComplete
            case .selection:
                    .selection
            case .start:
                    .start
            case .stop:
                    .stop
            case .success:
                    .success
            case .warning:
                    .warning
            case .impactrigid:
                    .impact(flexibility: .rigid)
            case .impactsoft:
                    .impact(flexibility: .soft)
            case .impactsolid:
                    .impact(flexibility: .solid)
            default:
                    .alignment // will never execute
            }
        }
    }
}

@available(iOS 17.5, macOS 14, *)
struct SwiftUIHapticsListRow: View {
    @State var haptic: SwiftUIFeedback
    @State private var clicks = 0
    @State private var info = false
    var body: some View {
        RowView(button: { clicks += 1 }, haptic: haptic)
            .sensoryFeedback(haptic.haptic.sensoryFeedback, trigger: clicks)
    }
}

#Preview {
    List {
        if #available(iOS 17.5, macOS 14.5, *) {
            SwiftUIHaptics()
        }
    }
}

//UINotificationFeedbackGenerator

//UISelectionFeedbackGenerator

//Core Haptics

//Apple Watch
