//
//  PieChartView.swift
//  cheddar
//
//  Created by Alexander Boswell on 6/15/24.
//

import SwiftUI


struct PieChartView: View {
	public let values: [Double]
	public let labels: [String]
	public var colors: [Color]
	
	public var backgroundColor: Color
	
	var slices: [PieSliceData] {
		let sum = values.reduce(0, +)
		var endDeg: Double = 0
		var tempSlices: [PieSliceData] = []
		
		for (i, value) in values.enumerated() {
			let degrees: Double = value * 360 / sum
			tempSlices.append(PieSliceData(startAngle: Angle(degrees: endDeg), endAngle: Angle(degrees: endDeg + degrees), text: String(format: "\(value != 0 ? labels[i] : "") %.0f%%", value * 100 / sum), color: self.colors[i]))
			endDeg += degrees
		}
		return tempSlices
	}
	
	var body: some View {
		GeometryReader { geometry in
			ZStack{
				ForEach(0..<self.values.count){ i in
					PieSliceView(pieSliceData: self.slices[i])
				}
				.frame(width: geometry.size.width, height: geometry.size.width)
			}
			.background(self.backgroundColor)
			.foregroundColor(Color.white)
		}
	}
}


struct PieSliceView: View {
	var pieSliceData: PieSliceData
	
	var midRadians: Double {
		return Double.pi / 2.0 - (pieSliceData.startAngle + pieSliceData.endAngle).radians / 2.0
	}
	
	var body: some View {
		GeometryReader { geometry in
			ZStack {
				Path { path in
					let width: CGFloat = min(geometry.size.width, geometry.size.height)
					let height = width
					
					let center = CGPoint(x: width * 0.5, y: height * 0.5)
					
					path.move(to: center)
					
					path.addArc(
						center: center,
						radius: width * 0.5,
						startAngle: Angle(degrees: -90.0) + pieSliceData.startAngle,
						endAngle: Angle(degrees: -90.0) + pieSliceData.endAngle,
						clockwise: false)
					
				}
				.fill(pieSliceData.color)
				
				Text(pieSliceData.text)
					.position(
						x: geometry.size.width * 0.5 * CGFloat(1.0 + 0.78 * cos(self.midRadians)),
						y: geometry.size.height * 0.5 * CGFloat(1.0 - 0.78 * sin(self.midRadians))
					)
					.foregroundColor(Color.white)
			}
		}
		.aspectRatio(1, contentMode: .fit)
	}
}

struct PieSliceData {
	var startAngle: Angle
	var endAngle: Angle
	var text: String
	var color: Color
}

