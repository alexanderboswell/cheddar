//
//  Category.swift
//  cheddar
//
//  Created by Alexander Boswell on 5/18/24.
//

import Foundation
import SwiftData

@Model
final class SpendingCategory {
	var lineItems: [LineItem]
	let type: CategoryType

	init(lineItems: [LineItem], type: CategoryType) {
		self.lineItems = lineItems
		self.type = type
	}

	var totalAmount: CGFloat {
		return lineItems.reduce(0) { $0 + $1.amount }
	}
}


enum CategoryType: Int, Codable, CaseIterable {
	case income = 4
	case personalExpenses = 3
	case businessExpenses = 2
	case debt = 1
	case savings = 0

	var title: String {
		switch self {
		case .income:
			"Income"
		case .personalExpenses:
			"Personal Expenses"
		case .businessExpenses:
			"Business Expenses"
		case .debt:
			"Debt"
		case .savings:
			"Savings"
		}
	}
}
