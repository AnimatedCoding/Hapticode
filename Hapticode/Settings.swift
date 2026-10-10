//
//  Settings.swift
//  Hapticode
//
//  Created by Noah on 10/3/26.
//

import SwiftUI

struct Settings: View {
	let appStoreURL = URL(string: "https://apps.apple.com/us/app/ColorPickers/id123456789")!
	let appStoreRateURL = URL(string: "https://apps.apple.com/us/app/10-000-color-pickers/id6753088532?action=write-review")!
	let githubRepoURL = URL(string: "https://github.com/AnimatedCoding/Hapticode")!
	@Environment(\.dismiss) private var dismiss
    var body: some View {
		NavigationStackOldCompatible {
			List {
//				Section("How do custom haptic work") {
//					Text("Custom haptics are here yet, oh!")
//				}
				Section("How to use") {
					Text("To use Hapticode, simple click on the rows in the main view and feel the haptics, its that easy!")
					Text("You can also make custom core haptic configurations and save them.")
					Text("You might notice that the warnings indicating that a haptic doesn't work on you device are wrong. I have, not sure why that happens. I used the official app documentation to get what operating systems each haptic works on, but it seems wrong.")
				}
				Section("About") {
					Text("Hapticode lets you experiment with what haptics you use in your app without building over and over.")
//					if #available(iOS 16.0, *) {
//						ShareLink(item: appStoreURL, subject: Text("Check out Hapticode!"), message: Text("Find the perfect haptic for your iOS app")) {
//							Text("Share App")
//						}
//					} else {
//						Link("Share App", destination: appStoreURL)
//					}
//					Link("Rate App", destination: appStoreRateURL)
					Link("Check out the sorce code", destination: githubRepoURL)
				}
				.font(.callout)
			}
			.toolbar {
				ToolbarItem(placement: .cancellationAction) {
					Button {
						dismiss()
					} label: {
						Label("Close", systemImage: "xmark")
					}
				}
			}
		}
    }
}

#Preview {
    Settings()
}
