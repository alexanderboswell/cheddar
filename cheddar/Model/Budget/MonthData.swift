//
//  MonthData.swift
//  cheddar
//
//  Created by Alexander Boswell on 7/29/24.
//

import SwiftData

@Model
final class MonthData {
	let spendingCategories: [SpendingCategory]
	var transactions: [Transaction]
	let categoryPercentageDict: [CategoryType: Int]

	var totalTransactionAmount: Double {
		return transactions.reduce(0) { $0 + $1.amount }
	}

	init(spendingCategoriesDict: [SpendingCategory: Int], transactions: [Transaction] = []) {
		var spendingCategories: [SpendingCategory] = []
		var categoryPercentageDict: [CategoryType: Int] = [:]
		for entry in spendingCategoriesDict {
			spendingCategories.append(entry.key)
			categoryPercentageDict[entry.key.type] = entry.value
		}
		self.spendingCategories = spendingCategories
		self.transactions = transactions
		// TODO: this value should be calculated based on previous month and should move the needle
		self.categoryPercentageDict = categoryPercentageDict
	}

	func amount(for categoryType: CategoryType) -> Double {
		return totalTransactionAmount * (Double(categoryPercentageDict[categoryType] ?? 0) / 100)
	}

	
}
