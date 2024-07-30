//
//  LineItem.swift
//  cheddar
//
//  Created by Alexander Boswell on 5/18/24.
//

import Foundation
import SwiftData

@Model
final class LineItem {
	var title: String
	var amount: Double

	init(title: String, amount: Double) {
		self.title = title
		self.amount = amount
	}
}
