//
//  Transaction.swift
//  cheddar
//
//  Created by Alexander Boswell on 7/29/24.
//

import SwiftData

@Model
final class Transaction {
	var amount: Double

	init(amount: Double) {
		self.amount = amount
	}
}
