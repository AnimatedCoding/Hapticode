//
//  Haptics.swift
//  Hapticode
//
//  Created by Noah on 7/14/26.
//

import Foundation
import SwiftData

protocol Haptic: Identifiable, Codable {
    var id: UUID { get }
    var name: String { get }
    var docURL: URL { get }
    var platforms: [Platform] { get }
}

enum Platform: String, Codable {
    case iOS, macOS, tvOS, watchOS, visionOS, notSpecified
}
