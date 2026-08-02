//
//  ContentView.swift
//  Hapticode
//
//  Created by Noah on 7/5/26.
//

import SwiftUI
import SwiftData

@available(iOS 16.0, *)
struct ContentView: View {
    //    @Environment(\.modelContext) private var modelContext
    //    @Query private var items: [Item]
    @Environment(\.colorScheme) private var colorScheme
    var body: some View {
        NavigationStack {
            List {
#if os(macOS)
                Text("Haptics do not play on macOS")
#endif
                if #available(iOS 17.5, *) {
                    SwiftUIHaptics()
                }
#if os(macOS)
#else
                UIKitHaptics()
#endif
                CoreHapticsList()
                //                ForEach(items) { item in
                //                    NavigationLink {
                //                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                //                    } label: {
                //                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                //                    }
                //                }
                //                .onDelete(perform: deleteItems)
            }
            .scrollContentBackground(.hidden)
            .background {
                var colors: [Color] {
                    if #available(iOS 18, macOS 15, *) {
                        [
                            colorScheme == .dark ? .blue.mix(with: .black, by: 0.5) : .blue.mix(with: .white, by: 0.95),
                            colorScheme == .dark ? .blue.mix(with: .black, by: 0.95) : .blue.mix(with: .white, by: 0.70)
                            
                        ]
                    } else {
                        []
                    }
                }
                LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
            }
            //            .toolbar {
            //                ToolbarItem(placement: .navigationBarTrailing) {
            //                    EditButton()
            //                }
            //                ToolbarItem {
            //                    Button(action: addItem) {
            //                        Label("Add Item", systemImage: "plus")
            //                    }
            //                }
            //            }
        }
    }
    
    //    private func addItem() {
    //        withAnimation {
    //            let newItem = Item(timestamp: Date())
    //            modelContext.insert(newItem)
    //        }
    //    }
    //
    //    private func deleteItems(offsets: IndexSet) {
    //        withAnimation {
    //            for index in offsets {
    //                modelContext.delete(items[index])
    //            }
    //        }
    //    }
}

#Preview {
    if #available(iOS 16, *) {
        ContentView()
        
        //.modelContainer(for: Item.self, inMemory: true)
    }
}
