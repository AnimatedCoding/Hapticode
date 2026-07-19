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
    @State private var showShareSheet = false
    @State private var showHelp = false
    let haptic: any Haptic
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
                Text(haptic.name)
                Spacer()
            }
            .supportsLongPress {
                #if os(macOS)
                let sharingPicker = NSSharingServicePicker(items: ["Check out the docs", haptic.docURL])
                sharingPicker.show(relativeTo: NSRect.zero, of: NSApp.keyWindow!.contentView!, preferredEdge: .minY)
                #else
                showShareSheet = true
                #endif
            }
            .contentShape(Rectangle())
            if !haptic.platforms.isEmpty && !haptic.platforms.contains(os) {
                Button(action: {
                    showHelp = true
                }) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundStyle(.orange)
                }
                .help("This haptic is not listed as available on your OS")
                .alert("This haptic is not listed as available on your OS", isPresented: $showHelp, actions: {
                    Button(role: .cancel, action: {
                        showHelp = false
                    }) {
                        Text("Ok")
                    }
                })
            }
        }
        .foregroundStyle(.primary)
        .buttonStyle(.borderless)
        #if os(macOS)
        #else
        EmptyView()
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(items: ["Check out the docs", haptic.docURL])
        }
        #endif
    }
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

#Preview {
    #if os(iOS)
    RowView(button: { print("Pressed") }, haptic: UIKitHaptic(name: "Heavy", haptic: .heavy, docURL: URL(string: "https://developer.apple.com/documentation/uikit/uiimpactfeedbackgenerator/feedbackstyle/heavy")!))
    #endif
}
