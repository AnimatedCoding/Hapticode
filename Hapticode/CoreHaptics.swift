//
//  CoreHaptics.swift
//  Hapticode
//
//  Created by Noah on 8/2/26.
//
//  Help from https://medium.com/appledeveloperacademy-ufpe/core-haptics-coding-sensory-experiences-with-vibrations-5fe245b4a743

import SwiftUI
import CoreHaptics

struct CoreHapticsList: View {
    @State private var info = false
    @State private var showAdder = false
    var body: some View {
        Section {
            Button(action: {
                showAdder.toggle()
            }) {
                Label("Add new haptic", systemImage: "plus")
            }
            Text("Currently I haven't implemented a saving feature, so you can't save haptics. But you can still have fun making them!")
            //            ForEach(haptics) { haptic in
            //                CoreHapticsListRow(haptic: haptic)
            //            }
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
                    CoreHapticsInfo()
                })
            }
        }
        .sheet(isPresented: $showAdder) {
            if #available(iOS 16.0, *) {
                CoreHapticsEditor()
                    .presentationDetents([.medium, .large])
            } else {
                CoreHapticsEditor()
            }
        }
    }
}

struct CoreHapticsInfo: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStackOldCompatible {
            List {
                Text("These are haptics you can make using Core Haptics (CHHapticEngine). Here's an example:")
                ScrollView(.horizontal) {
                    Text(
###"""
struct ContentView: View {
    var body: some View {
        Button(haptic.name) {
            var engine: CHHapticEngine?
            do {
                engine = try CHHapticEngine()
                
                try engine?.start()
            } catch {
                print("Haptic engine Start Error: \(error.localizedDescription)")
            }
            
            guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
            
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)
            
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
            
            let event = CHHapticEvent(eventType: .hapticContinuous, parameters: [intensity, sharpness], relativeTime: 0, duration: 1)
            do {
                let pattern = try CHHapticPattern(events: [event], parameters: [])
                
                let player = try engine?.makePlayer(with: pattern)
                
                try player?.start(atTime: 0)
            } catch {
                print("Failed to play haptic: \(error.localizedDescription)")
            }
        }
    }
}
"""###
                    )
                    
                    .listRowBackground (
                        RoundedRectangle(cornerSize: CGSize(width: 0.5, height: 0.5), style: .continuous)
                            .foregroundStyle(.background)
                    )
                }
                Link("Docs", destination: URL(string: "https://developer.apple.com/documentation/corehaptics/chhapticengine")!)
            }
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

struct CoreHapticsListRow: View {
    var body: some View {
        Text("Nothing")
    }
}

struct CoreHapticsEditor: View {
    @State private var engine: CHHapticEngine?
    @State private var delay: Double = 0
    @State private var length: Double = 1
    @State private var intensity: Float = 1
    @State private var sharpness: Float = 1
    @State private var continuous = false
    
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStackOldCompatible {
            List {
                Toggle("Continuous", isOn: $continuous)
                Text("Intensity (0...1): \(String(format: "%.2f", intensity))")
                Slider(value: $intensity, in: 0...1)
                Text("Sharpness (0...1): \(String(format: "%.2f", sharpness))")
                Slider(value: $sharpness, in: 0...1)
                Stepper("Haptic lenght (duration) in seconds: \(String(format: "%.2f", length))", value: $length, step: 0.1)
                    .disabled(!continuous)
                    .opacity(continuous ? 1 : 0.5)
                Stepper("Delay (relativeTime) in seconds: \(String(format: "%.2f", delay))", value: $delay, step: 0.1)
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        dismiss()
                    }) {
                        Label("Close", systemImage: "xmark")
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        prepareHaptics()
                        startHaptics()
                    }) {
                        Label("Play Haptic", systemImage: "play")
                    }
                }
//                ToolbarItem(placement: .confirmationAction) {
//                    Button(action: {
//                        save()
//                        dismiss()
//                    }) {
//                        Label("Ok", systemImage: "checkmark")
//                    }
//                }
            }
            .navigationTitle("Make a core haptics haptic")
        }
    }
    private func save() {
        // Does nothing now, but will save to SwiftData
    }
    private func prepareHaptics() {
        do {
            engine = try CHHapticEngine()
            
            try engine?.start()
        } catch {
            print("Haptic engine Start Error: \(error.localizedDescription)")
        }
    }
    private func startHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity)
        
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: sharpness)
        
        let event = CHHapticEvent(eventType: continuous ? .hapticContinuous : .hapticTransient, parameters: [intensity, sharpness], relativeTime: delay, duration: length)
        
        // Will figure out later
        //        let dynamicIntensity = CHHapticDynamicParameter(
        //            parameterID: .hapticIntensityControl,
        //            value: 1, // Set intensity to 50%
        //            relativeTime: 0.1 // Start at 0.1 seconds into the pattern
        //        )
        
        playHaptics(events: [event], perams: [])
    }
    private func playHaptics(events: [CHHapticEvent], perams: [CHHapticDynamicParameter]) {
        do {
            let pattern = try CHHapticPattern(events: events, parameters: perams)
            
            let player = try engine?.makePlayer(with: pattern)
            
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play haptic: \(error.localizedDescription)")
        }
    }
}

#Preview {
    List {
        CoreHapticsList()
    }
}
