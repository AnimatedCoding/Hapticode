//
//  SafariViewWrapper.swift
//  Hapticode
//
//  Created by Noah on 9/2/26.
//
// AI helped me make the web view

import SwiftUI
import SafariServices

struct SafariViewWrapper: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariViewWrapper>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariViewWrapper>) {}
}

extension View {
    func safariWebSheet(isPresented: Binding<Bool>, url: URL) -> some View {
        self.sheet(isPresented: isPresented) { SafariViewWrapper(url: url) }
    }
}

struct SafariViewButton: View {
    let title: String
    let url: URL
    @State private var isPresented: Bool = false
    
    var body: some View {
        Button(action: { isPresented = true }) {
            Text(title)
        }
        .safariWebSheet(isPresented: $isPresented, url: url)
    }
}
