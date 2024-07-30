//
//  IncomeCalculatorView.swift
//  cheddar
//
//  Created by Alexander Boswell on 6/15/24.
//

import SwiftUI

struct IncomeCalculatorView: View {
    var body: some View {
		VStack {
			Text("Pay Yourself!")
				.font(.title)
			HStack {
				Spacer()
				TextField("Amount", value: $amount, formatter: currencyFormatter)
					.keyboardType(.decimalPad)
			}
			List {
				ListItem(description: "Personal Expenses (40%)", amount: amount * 0.4)
				ListItem(description: "Business Expenses (15%)", amount: amount * 0.15)
				ListItem(description: "Taxes (15%)", amount: amount * 0.15)
				ListItem(description: "Savings (10%)", amount: amount * 0.1)
				ListItem(description: "Investments (10%)", amount: amount * 0.1)
				ListItem(description: "Debt (5%)", amount: amount * 0.05)
				ListItem(description: "Profit Disribution (5%)", amount: amount * 0.05)
			}
		}
    }

	@State var amount: Double = 0.0

	var currencyFormatter: NumberFormatter = {
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		formatter.maximumFractionDigits = 2
		formatter.minimumFractionDigits = 2
		return formatter
	}()
}

struct ListItem: View {
	let description: String
	var amount: CGFloat

	var body: some View {
		HStack {
			Text(description)
			Spacer()
			Text(String(format: "$%.02f", amount))
		}
	}
}

#Preview {
    IncomeCalculatorView()
}
