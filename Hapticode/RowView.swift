//
//  RowView.swift
//  Hapticode
//
//  Created by Noah on 7/14/26.
//

import SwiftUI

struct RowView: View {
    @Environment(\.openURL) private var openURL

    let button: () -> Void
    @State private var webSheet = false
    @State private var showHelp = false
    let haptic: any Haptic
    var action: (closure: () -> Void, use: Bool) = (closure: {}, use: false)
    var longPress: () -> Void {
        if action.use {
            return action.closure
        } else {
            return {
//#if os(macOS)
//                    let sharingPicker = NSSharingServicePicker(items: ["Check out the docs", haptic.docURL])
//                    sharingPicker.show(relativeTo: NSRect.zero, of: NSApp.keyWindow!.contentView!, preferredEdge: .minY)
//#else
                webSheet = true
//#endif
            }
        }
    }
    private var os: Platform {
        get {
#if os(iOS)
            .iOS
#elseif os(macOS)
            .macOS
#elseif os(tvOS)
            .tvOS
#elseif os(watchOS)
            .watchOS
#elseif os(visionOS)
            .visionOS
#endif
        }
    }
    var body: some View {
        HStack {
            Button(action: {
                button()
            }) {
                if haptic.name.isEmpty {
                    Text("No name")
                        .opacity(0.5)
                } else {
                    Text(haptic.name)
                }
                Spacer()
            }
            .supportsLongPress {
                longPress()
            }
            .contentShape(Rectangle())
            if !haptic.platforms.isEmpty && !haptic.platforms.contains(os) {
                Button(action: {
                    showHelp = true
                }) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundStyle(.orange)
                }
                .alert("This haptic is not listed as available on your OS", isPresented: $showHelp, actions: {
                    Button(role: .cancel, action: {
                        showHelp = false
                    }) {
                        Text("Ok")
                    }
                })
            }
        }
        .accessibilityChildren(children: {
            HStack {
                if haptic.name.isEmpty {
                    Text("This haptic does not have a name")
                } else {
                    Text(haptic.name)
                }
                if !haptic.platforms.isEmpty && !haptic.platforms.contains(os) {
                    Text("This haptic is not listed as available on your OS")
                }
            }
            .accessibilityElement(children: .combine)
        })
        .foregroundStyle(.primary)
        .buttonStyle(.borderless)
        #if os(macOS)
        .modifier(EmptyModifier())
        #else
        .sheet(isPresented: $webSheet) {
            SafariViewWrapper(url: haptic.docURL)
        }
        #endif
    }
}

#Preview("Row view") {
    #if os(iOS)
    RowView(button: { print("Pressed") }, haptic: UIKitImpactHaptic(name: "Heavy", haptic: .heavy, docURL: URL(string: "https://developer.apple.com/documentation/uikit/uiimpactfeedbackgenerator/feedbackstyle/heavy")!))
    #endif
}

// Source - https://stackoverflow.com/a/76412638
// Posted by Steve Barnes
// Retrieved 2026-07-14, License - CC BY-SA 4.0

// Conform to `PrimitiveButtonStyle` for custom interaction behaviour

struct SupportsLongPress: PrimitiveButtonStyle {
    
    /// An action to execute on long press
    let longPressAction: () -> ()
    
    /// Whether the button is being pressed
    @State var isPressed: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        
        // The "label" as specified when declaring the button
        configuration.label
        
        // Visual feedback that the button is being pressed
            .scaleEffect(self.isPressed ? 0.9 : 1.0)
        
            .onTapGesture {
                
                // Run the "action" as specified
                // when declaring the button
                configuration.trigger()
                
            }
        
            .onLongPressGesture(
                
                perform: {
                    
                    // Run the action specified
                    // when using this style
                    self.longPressAction()
                    
                },
                
                onPressingChanged: { pressing in
                    
                    // Use "pressing" to infer whether the button
                    // is being pressed
                    self.isPressed = pressing
                    
                }
                
            )
        
    }
    
}

/// A modifier that applies the `SupportsLongPress` style to buttons
struct SupportsLongPressModifier: ViewModifier {
    let longPressAction: () -> ()
    func body(content: Content) -> some View {
        content.buttonStyle(SupportsLongPress(longPressAction: self.longPressAction))
    }
}

/// Extend the View protocol for a SwiftUI-like shorthand version
extension View {
    func supportsLongPress(longPressAction: @escaping () -> ()) -> some View {
        modifier(SupportsLongPressModifier(longPressAction: longPressAction))
    }
}
