//
//  CoreHaptics.swift
//  Hapticode
//
//  Created by Noah on 8/2/26.
//
//  Help from https://medium.com/appledeveloperacademy-ufpe/core-haptics-coding-sensory-experiences-with-vibrations-5fe245b4a743

import SwiftUI
import SwiftData
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
            .sheet(isPresented: $showAdder) {
                if #available(iOS 16.0, *) {
                    CoreHapticsMaker()
                        .presentationDetents([.medium, .large])
                } else {
                    CoreHapticsMaker()
                }
            }
            if #available(iOS 17, *) {
                CoreHapticsSavedList()
            } else {
                Text("Currently I haven't implemented a saving feature, so you can't save haptics. But you can still have fun making them!")
            }
        } header: {
            HStack {
                Text("Core Haptics")
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
                SafariViewButton(title: "Docs", url: URL(string: "https://developer.apple.com/documentation/corehaptics/chhapticengine")!)
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

struct CoreHapticsMaker: View {
    @State private var engine: CHHapticEngine?
    @State private var haptic = CoreHaptic()
    
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStackOldCompatible {
            List {
                Section("Make a core haptics haptic") {
                    if #available(iOS 17, *) {
                        TextField("Name", text: $haptic.name)
                    }
                    Toggle("Continuous", isOn: $haptic.continuous)
                    Text("Intensity (0...1): \(String(format: "%.2f", haptic.intensity))")
                    Slider(value: $haptic.intensity, in: 0...1)
                    Text("Sharpness (0...1): \(String(format: "%.2f", haptic.sharpness))")
                    Slider(value: $haptic.sharpness, in: 0...1)
                    Stepper("Haptic lenght (duration) in seconds: \(String(format: "%.2f", haptic.length))", value: $haptic.length, step: 0.1)
                        .disabled(!haptic.continuous)
                        .opacity(haptic.continuous ? 1 : 0.5)
                    Stepper("Delay (relativeTime) in seconds: \(String(format: "%.2f", haptic.delay))", value: $haptic.delay, step: 0.1)
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        dismiss()
                    }) {
                        Label("Close", systemImage: "xmark")
                    }
                }
                ToolbarItemGroup(placement: .confirmationAction) {
                    Button(action: {
                        prepareHaptics()
                        startHaptics()
                    }) {
                        Label("Play Haptic", systemImage: "play")
                    }
                    if #available(iOS 17, *) {
                        AddButton(haptic: $haptic)
                    }
                }
            }
        }
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
        
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: haptic.intensity)
        
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: haptic.sharpness)
        
        let event = CHHapticEvent(eventType: haptic.continuous ? .hapticContinuous : .hapticTransient, parameters: [intensity, sharpness], relativeTime: haptic.delay, duration: haptic.length)
        
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

struct CoreHaptic: Haptic {
    var id = UUID()
    var name = ""
    var docURL = URL(string: "https://developer.apple.com/documentation/corehaptics/chhapticengine")!
    var platforms: [Platform] = []
    var delay: Double = 0
    var length: Double = 1
    var intensity: Float = 1
    var sharpness: Float = 1
    var continuous = false
}

//MARK: -- SwiftData stuff
// Should move this to its own file

@available(iOS 17.0, *)
struct CoreHapticsEditor: View {
    @State private var engine: CHHapticEngine?
    @Bindable var container: CoreHapticContainer
    @State private var haptic = CoreHaptic()
    @State private var chache: CoreHaptic?
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStackOldCompatible {
            List {
                Section("Edit \(container.haptic.name)") {
                    if #available(iOS 17, *) {
                        TextField("New name", text: $haptic.name)
                    }
                    Toggle("Continuous", isOn: $haptic.continuous)
                    Text("Intensity (0...1): \(String(format: "%.2f", haptic.intensity))")
                    Slider(value: $haptic.intensity, in: 0...1)
                    Text("Sharpness (0...1): \(String(format: "%.2f", haptic.sharpness))")
                    Slider(value: $haptic.sharpness, in: 0...1)
                    Stepper("Haptic lenght (duration) in seconds: \(String(format: "%.2f", haptic.length))", value: $haptic.length, step: 0.1)
                        .disabled(!haptic.continuous)
                        .opacity(haptic.continuous ? 1 : 0.5)
                    Stepper("Delay (relativeTime) in seconds: \(String(format: "%.2f", haptic.delay))", value: $haptic.delay, step: 0.1)
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        dismiss()
                    }) {
                        Label("Close", systemImage: "xmark")
                    }
                }
                ToolbarItemGroup(placement: .confirmationAction) {
                    Button(action: {
                        prepareHaptics()
                        startHaptics()
                    }) {
                        Label("Play Haptic", systemImage: "play")
                    }
                    Button(action: {
                        container.haptic = haptic
                        dismiss()
                    }) {
                        Label("Ok", systemImage: "checkmark")
                    }
                }
            }
        }
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
        
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: haptic.intensity)
        
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: haptic.sharpness)
        
        let event = CHHapticEvent(eventType: haptic.continuous ? .hapticContinuous : .hapticTransient, parameters: [intensity, sharpness], relativeTime: haptic.delay, duration: haptic.length)
        
         // Will figure out later
//                let dynamicIntensity = CHHapticDynamicParameter(
//                    parameterID: .hapticIntensityControl,
//                    value: 1, // Set intensity to 50%
//                    relativeTime: 0.1 // Start at 0.1 seconds into the pattern
//                )
        
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

@available(iOS 17, *)
struct AddButton: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var alert = false
    @Binding var haptic: CoreHaptic
    var body: some View {
        Button(action: {
            if haptic.name.isEmpty {
                alert = true
            } else {
                modelContext.insert(CoreHapticContainer(haptic: haptic))
                dismiss()
            }
        }) {
            Label("Add", systemImage: "plus")
        }
        .alert("Are you sure you want to add this haptic without a name?", isPresented: $alert, actions: {
            Button("Cancel") {
                alert = false
            }
            Button("Add anyway", action: {
                alert = false
                modelContext.insert(CoreHapticContainer(haptic: haptic))
                dismiss()
            })
        })
    }
}

@available(iOS 17, *)
@Model
class CoreHapticContainer {
    var haptic: CoreHaptic
    init(haptic: CoreHaptic) {
        self.haptic = haptic
    }
}

@available(iOS 17, *)
struct CoreHapticsSavedList: View {
    @Query private var haptics: [CoreHapticContainer]
    @State private var editing: UUID? // Can't use a the CoreHapticContainer here because the list row doesn't like making a optional bindable
    @Environment(\.modelContext) private var modelContext
    var body: some View {
        ForEach(haptics.sorted(by: { $0.haptic.name > $1.haptic.name })) { container in
            CoreHapticsListRow(container: container, editing: $editing)
        }
        .onDelete(perform: delete)
        .sheet(isPresented: .constant(editing != nil), onDismiss: {
            editing = nil
        }) {
            if let editing, let haptic = haptics.first(where: { $0.haptic.id == editing }) {
                CoreHapticsEditor(container: haptic)
            }
        }
    }
    func delete(at offsets: IndexSet) {
        print(haptics)
        print(offsets)
        for offset in offsets {
            let haptic = haptics.sorted(by: { $0.haptic.name > $1.haptic.name })[offset]
            print("removing: ", haptic.haptic)
            modelContext.delete(haptic)
        }
    }
}

@available(iOS 17, *)
struct CoreHapticsListRow: View {
    @Bindable var container: CoreHapticContainer
    @Binding var editing: UUID?
    var body: some View {
        RowView(button: {
            print("Running button")
            var engine: CHHapticEngine?
            do {
                engine = try CHHapticEngine()
                
                try engine?.start()
            } catch {
                print("Haptic engine Start Error: \(error.localizedDescription)")
            }
            guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
            
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: container.haptic.intensity)
            
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: container.haptic.sharpness)
            
            let event = CHHapticEvent(eventType: container.haptic.continuous ? .hapticContinuous : .hapticTransient, parameters: [intensity, sharpness], relativeTime: container.haptic.delay, duration: container.haptic.length)
            
            // Will figure out later
            //        let dynamicIntensity = CHHapticDynamicParameter(
            //            parameterID: .hapticIntensityControl,
            //            value: 1, // Set intensity to 50%
            //            relativeTime: 0.1 // Start at 0.1 seconds into the pattern
            //        )
            do {
                let pattern = try CHHapticPattern(events: [event], parameters: [])
                
                let player = try engine?.makePlayer(with: pattern)
                
                try player?.start(atTime: 0)
            } catch {
                print("Failed to play haptic: \(error.localizedDescription)")
            }
        }, haptic: container.haptic, action: (closure: {
            editing = container.haptic.id
        }, use: true))
    }
}

#Preview {
    List {
        CoreHapticsList()
    }
}
