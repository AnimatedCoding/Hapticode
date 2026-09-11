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
                            .listRowBackground (
                                RoundedRectangle(cornerSize: CGSize(width: 0.5, height: 0.5), style: .continuous)
                                    .foregroundStyle(.background)
                            )
                    }
                    SafariViewButton(title: "Docs", url: haptic.docs)
                }
            }
            .textCase(.none)
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
    }
}

struct HapticsInfo {
    var title: String
    var example: String
    var docs: URL
}


#Preview {
    InfoSheet(haptic: HapticsInfo(title: "This is", example: "a haptic", docs: URL(string: "example.com?is=it_realy?")!))
}
