//
//  ReviewManager.swift
//  Hapticode
//
//  Created by Noah on 10/29/26.
//

import Foundation
import StoreKit

@MainActor
class ReviewManager {
	static let shared = ReviewManager()
	
	private init() {
		let old = UserDefaults.standard.integer(forKey: "app_opens")
		UserDefaults.standard.set(old + 1, forKey: "app_opens")
//		print("Old opens", old, "Now increasing by 1")
	}
	
	private var significantEvents = 0
	
	private var opens: Int {
//#if DEBUG
//		return 2
//#else
		UserDefaults.standard.integer(forKey: "app_opens")
//#endif
	}
	
	func registerEvent() {
//		print("Registered event")
		significantEvents += 1
//		print("Events now", significantEvents)
		requestReviewIfShould()
	}
	
	func requestReviewIfShould() {
		guard significantEvents > 3 && (opens.isMultiple(of: 13) || opens == 2 ) else { return }
//		print("Requesting review")
		if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
			if #available(iOS 16, *) {
				AppStore.requestReview(in: scene)
			} else {
				SKStoreReviewController.requestReview(in: scene)
			}
		}
	}
}
