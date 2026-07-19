//
//  Haptics.swift
//  Hapticode
//
//  Created by Noah on 7/14/26.
//

import Foundation

protocol Haptic: Identifiable {
    var id: UUID { get }
    var name: String { get }
    var docURL: URL { get }
    var platforms: [Platform] { get }
}

enum Platform {
    case iOS, macOS, tvOS, watchOS, visionOS, notSpecified
}
