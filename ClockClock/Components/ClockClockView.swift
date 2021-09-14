//
//  ClockClockView.swift
//  ClockClock
//
//  Created by Korel Hayrullah on 12.09.2021.
//

import UIKit

class ClockClockView: UIView {
	// MARK: - Properties
	private lazy var stack: UIStackView = {
		let stack = UIStackView()
		stack.backgroundColor = .clear
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.alignment = .fill
		stack.distribution = .fillEqually
		stack.spacing = 10
		stack.axis = .vertical
		return stack
	}()
	
	override var intrinsicContentSize: CGSize {
		return stack.intrinsicContentSize
	}
	
	private var clocks: [[ClocksView]] = []
	
	// MARK: - Init
	override init(frame: CGRect) {
		super.init(frame: frame)
		initialize()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		initialize()
	}
	
	private func initialize() {
		backgroundColor = .clear
		addSubview(stack)
		NSLayoutConstraint.activate([
			stack.leadingAnchor.constraint(equalTo: leadingAnchor),
			stack.trailingAnchor.constraint(equalTo: trailingAnchor),
			stack.topAnchor.constraint(equalTo: topAnchor),
			stack.bottomAnchor.constraint(equalTo: bottomAnchor),
		])
		
		for _ in 0..<2 {
			var row: [ClocksView] = []
			
			let rowStack = UIStackView()
			rowStack.backgroundColor = .clear
			rowStack.translatesAutoresizingMaskIntoConstraints = false
			rowStack.alignment = .fill
			rowStack.distribution = .fillEqually
			rowStack.spacing = 10
			rowStack.axis = .horizontal
			
			for _ in 0..<2 {
				let clocksView = ClocksView()
				row.append(clocksView)
				rowStack.addArrangedSubview(clocksView)
			}
			
			stack.addArrangedSubview(rowStack)
			clocks.append(row)
		}
	}
	
	// MARK: - Methods
	func redraw() {
		for i in 0..<2 {
			for j in 0..<2 {
				clocks[i][j].redraw()
			}
		}
	}
	
	func update(_ date: Date = Date(), duration: Double) {
		let comps = Calendar.current.dateComponents([.hour, .minute], from: Date())
		
		let hour = String(format: "%02d", comps.hour ?? 0)
		let minute = String(format: "%02d", comps.minute ?? 0)
		
		let hourStart = hour[hour.startIndex]
		let hourEnd = hour[hour.index(hour.startIndex, offsetBy: 1)]
		
		let minuteStart = minute[minute.startIndex]
		let minuteEnd = minute[minute.index(minute.startIndex, offsetBy: 1)]
		
		guard
			let hourHigh = Int(String(hourStart)),
			let hourLow = Int(String(hourEnd)),
			let minuteHigh = Int(String(minuteStart)),
			let minuteLow = Int(String(minuteEnd))
		else { return }
		
		clocks[0][0].animate(to: hourHigh, duration: duration)
		clocks[0][1].animate(to: hourLow, duration: duration)
		clocks[1][0].animate(to: minuteHigh, duration: duration)
		clocks[1][1].animate(to: minuteLow, duration: duration)
	}
}
