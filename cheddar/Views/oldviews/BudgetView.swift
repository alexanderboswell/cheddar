//
//  BudgetView.swift
//  cheddar
//
//  Created by Alexander Boswell on 5/18/24.
//

import SwiftData
import SwiftUI

struct BudgetView: View {
	@Environment(\.modelContext) private var modelContext
	@Query private var categories: [SpendingCategory]
    var body: some View {
		List {
			ForEach(categories) { category in
				Section {
					
					ForEach(category.lineItems) { lineItem in
						HStack {
							Text(lineItem.title)
							Spacer()
							Text(String(format: "$%.02f", lineItem.amount))
						}
						
					}
					.onDelete(perform: { indexSet in
						for index in indexSet {
							category.lineItems.remove(at: index)
						}
					})
					HStack {
						Text("Total")
							.bold()
						Spacer()
						Text(String(format: "$%.02f", category.totalAmount))
							.bold()
					}
					
					Button {
						selectedCategory = category
						isSheetPresented = true
					} label: {
						Text("Add")
					}

				} header: {
					Text(category.type.title)
						.textCase(nil)
				}
				
				
			}
			PieChartView(values: categories.map { $0.totalAmount },labels: categories.map { $0.type.title },  colors: [.blue, .red , .green, .yellow, .orange], backgroundColor: .white)
				.frame(height: 500)
		}
		.listStyle(.insetGrouped)
		.onAppear {
			if categories.isEmpty {
				for type in CategoryType.allCases {
					modelContext.insert(SpendingCategory(lineItems: [], type: type))
				}
			}
		}
		.sheet(isPresented: $isSheetPresented, content: {
				addLineItemView(onItemAddedBlock: { newLineItem in
					selectedCategory?.lineItems.append(newLineItem)
				})
					.presentationDetents([.height(250)])
				//				.presentationDragIndicator(.visible)
		})
    }

	@State private var isSheetPresented: Bool = false
	@State private var selectedCategory: SpendingCategory?
}

struct addLineItemView: View {

	let onItemAddedBlock: ((LineItem) -> ())
	
	var body: some View {
		VStack {
			VStack(alignment: .leading) {
				Text("New Item")
					.font(.title)
				TextField(text: $lineItemDescription) {
					Text("Description")
				}
				TextField("Amount", value: $amount, formatter: currencyFormatter)
					.keyboardType(.decimalPad)
			}
			.padding()
			Button(action: {
				onItemAddedBlock(LineItem(title: lineItemDescription, amount: amount))
				dismiss()
			}, label: {
				Text("Add")
			})
			.disabled(lineItemDescription.isEmpty || amount == 0.00)
		}
	}

	@State private var lineItemDescription: String = ""
	@State private var amount: Double = 0.00
	@Environment(\.dismiss) private var dismiss

	var currencyFormatter: NumberFormatter = {
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		formatter.maximumFractionDigits = 2
		formatter.minimumFractionDigits = 2
		return formatter
	}()
}

#Preview {
    BudgetView()
		.modelContainer(for: SpendingCategory.self, inMemory: true)
}
