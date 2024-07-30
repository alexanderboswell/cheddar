//
//  HomeView.swift
//  cheddar
//
//  Created by Alexander Boswell on 7/29/24.
//

import SwiftUI

struct SummaryView: View {
    var body: some View {
		NavigationStack {
			Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
				.navigationTitle("Monthly Pay")
				.toolbarTitleDisplayMode(.inlineLarge)
				.toolbar {
					ToolbarItem(placement: .topBarTrailing) {
						Button("Add payment") {
							
						}
					}
				}
		}
    }
}

#Preview {
	SummaryView()
}
