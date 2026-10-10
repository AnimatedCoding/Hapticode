//
//  ComboView.swift
//  Hapticode
//
//  Created by Noah on 8/28/26.
//

import SwiftUI
import SwiftData

@available(iOS 17.5, *)
struct ComboView: View {
	@State private var info = false
	@State private var showAdder = false
    var body: some View {
		Section {
			Button(action: {
				showAdder.toggle()
			}) {
				Label("Add new Haptic Combo", systemImage: "plus")
			}
			.sheet(isPresented: $showAdder) {
				ComboEditor()
					.presentationDetents([.medium, .large])
			}
//			ForEach(swiftUIHaptics) { haptic in
//				SwiftUIHapticsListRow(haptic: haptic)
//			}
		} header: {
			HStack {
				Text("Haptic Combos")
				Spacer()
				Button(action: {
					info = true
				}) {
					Image(systemName: "info")
				}
//				.sheet(isPresented: $info, content: {
//					InfoSheet(haptic: HapticsInfo(title: "These are haptics you can get with the .sensoryFeedback(SensoryFeedback, trigger: Equatable). Here's an example:", example:
//					"""
//					struct ContentView: View {
//						@State private var clicks = 0
//						var body: some View {
//							Button("Increase") {
//								clicks += 1
//							}
//							.sensoryFeedback(.increase, trigger: clicks)
//						}
//					}
//					""",
//					docs: URL(string: "https://developer.apple.com/documentation/swiftui/view/sensoryfeedback(_:trigger:)")!))
//				})
			}
		}
    }
}

@available(iOS 17.5, *)
struct ComboEditor: View {
	@State private var combo = Combo(name: "")
	var body: some View {
		TextField("Name", text: $combo.name)
		ForEach(combo.hapticList) { haptic in
			
		}
	}
}

#Preview {
	if #available(iOS 17.5, *) {
		ComboView()
	}
}
