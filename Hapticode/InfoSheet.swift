//
//  InfoSheet.swift
//  Hapticode
//
//  Created by Noah on 9/11/26.
//

import SwiftUI

struct InfoSheet: View {
    @Environment(\.dismiss) private var dismiss
    let haptic: HapticsInfo
    var body: some View {
        NavigationStackOldCompatible {
            List {
                Section {
                    Text(haptic.title)
                    ScrollView(.horizontal) {
                        Text(haptic.example)
							.textSelection(.enabled)
							.padding(.horizontal)
                    }
					.padding(.vertical)
//					.overlay(alignment: .leading) {
						// Gradient
//					}
					.background {
						Color.gray
							.opacity(0.25)
							.frame(maxWidth: .infinity, maxHeight: .infinity)
					}
					.clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
                    SafariViewButton(title: "Docs", url: haptic.docs)
                }
				.listRowSeparator(.hidden)
            }
            .textCase(.none)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                    }
                }
            }
			.navigationTitle(haptic.navTitle)
        }
    }
}

struct HapticsInfo {
	var navTitle: String
    var title: String
    var example: String
    var docs: URL
}


#Preview {
	InfoSheet(haptic: HapticsInfo(navTitle: "Title", title: "This is", example: "a haptic", docs: URL(string: "example.com?is=it_realy?")!))
}
