//
//  Modifiers.swift
//  Hapticode
//
//  Created by Noah on 7/19/26.
//

import SwiftUI

//extension View {
//    @ViewBuilder
//    func `transforming`<Content: View>(transform: (Self) -> Content) -> some View {
//        transform(self)
//    }
//}

#if os(macOS)

#else
import UIKit

struct ShareSheet: UIViewControllerRepresentable {
    var items: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        return activityVC
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // No update needed
    }
}
#endif

struct NavigationStackOldCompatible<Content: View>: View {
    @ViewBuilder var content: () -> Content
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                content()
            }
        } else {
            NavigationView {
                content()
            }
        }
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
	
	@Environment(\.accessibilityReduceMotion) private var reduceMotion
	
	func makeBody(configuration: Configuration) -> some View {
		
		// The "label" as specified when declaring the button
		configuration.label
		
		// Visual feedback that the button is being pressed
			.scaleEffect(self.isPressed ? 0.9 : 1.0)
			.animation(reduceMotion ? .smooth : .bouncy(extraBounce: 0.2), value: isPressed)
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
