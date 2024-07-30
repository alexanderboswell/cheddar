//
//  ContentView.swift
//  cheddar
//
//  Created by Alexander Boswell on 6/15/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
		TabView {
			SummaryView()
				.tabItem {
					VStack {
						Image(systemName: "house.fill")
						Text("Current Month")
					}
					
				}
			AdditionalInfoView()
				.tabItem {
					VStack {
						Image(systemName: "questionmark.bubble.fill")
						Text("FAQ")
					}
				}
		}
    }
}

#Preview {
    ContentView()
}
