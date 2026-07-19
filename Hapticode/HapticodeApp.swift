//
//  HapticodeApp.swift
//  Hapticode
//
//  Created by Noah on 7/5/26.
//

import SwiftUI
import SwiftData

@main
struct HapticodeApp: App {
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            Item.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()

    var body: some Scene {
        WindowGroup {
            VStack {
                if #available(iOS 16, *) {
                    ContentView()
                } else {
                    #if os(macOS)
                    #else
                    Legacy_iOS_16_View()
                    #endif
                }
            }
        }
        //.modelContainer(sharedModelContainer)
    }
}
