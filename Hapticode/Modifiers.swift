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
