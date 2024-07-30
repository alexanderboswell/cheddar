//
//  cheddarTests.swift
//  cheddarTests
//
//  Created by Alexander Boswell on 5/18/24.
//

import SwiftData
import XCTest

final class cheddarTests: XCTestCase {
	@MainActor
	let testContainer: ModelContainer = {
		do {
			let container = try ModelContainer (for: MonthData.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
			return container
		} catch {
			fatalError("Failed to create container")
		}
	}()

	@MainActor func testCategoryTotalAmount() throws {
		let amount1: CGFloat = 30.15
		let amount2: CGFloat = 1250.00
		let amount3: Double = 305.35
		let spendingCategory = SpendingCategory(lineItems: [
			LineItem(title: "Eating out", amount: amount1),
			LineItem(title: "Rent", amount: amount2),
			LineItem(title: "Gas", amount: amount3)
		], type: .personalExpenses)
		
		debugPrint(spendingCategory)
		
		testContainer.mainContext.insert(spendingCategory)
		
		do {
			try testContainer.mainContext.save()
		} catch {
			fatalError("Failed to save")
		}

		XCTAssertEqual(spendingCategory.totalAmount, amount1 + amount2 + amount3)
	}

	@MainActor func testAmountPerSpendingCategory() throws {
		let personalAmount1: Double = 30.15
		let personalAmount2: Double = 1250.00
		let personalAmount3: Double = 305.35
		let personalCategory = SpendingCategory(lineItems: [
			LineItem(title: "Eating out", amount: personalAmount1),
			LineItem(title: "Rent", amount: personalAmount2),
			LineItem(title: "Gas", amount: personalAmount3)
		], type: .personalExpenses)
	
		let businessAmount1: Double = 554.35
		let businessAmount2: Double = 87.54
		let businessCategory = SpendingCategory(lineItems: [
			LineItem(title: "Office space", amount: businessAmount1),
			LineItem(title: "Cell phone", amount: businessAmount2)
		], type: .businessExpenses)

		let personalSpendingPercentage = 70
		let businessSpendingPercentage = 30
		var spendingCategoriesDict: [SpendingCategory: Int] = [:]
		spendingCategoriesDict[personalCategory] = personalSpendingPercentage
		spendingCategoriesDict[businessCategory] = businessSpendingPercentage
		
		let transactionAmount1 = 303.23
		let transactionAmount2 = 154.25
		let monthData = MonthData(
			spendingCategoriesDict: spendingCategoriesDict,
			transactions: [
				Transaction(amount: transactionAmount1),
				Transaction(amount: transactionAmount2)
		])

		testContainer.mainContext.insert(monthData)
		
		do {
			try testContainer.mainContext.save()
		} catch {
			fatalError("Failed to save")
		}

		XCTAssertEqual(monthData.amount(for: .personalExpenses), 320.236)
		XCTAssertEqual(monthData.amount(for: .businessExpenses), 137.244)
		XCTAssertEqual(monthData.amount(for: .personalExpenses) + monthData.amount(for: .businessExpenses), transactionAmount1 + transactionAmount2)
	}
	
	
	override func setUpWithError() throws {
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
