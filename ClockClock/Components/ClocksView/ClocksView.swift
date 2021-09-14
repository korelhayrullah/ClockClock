//
//  ClocksView.swift
//  ClockClock
//
//  Created by Korel Hayrullah on 12.09.2021.
//

import UIKit

class ClocksView: UIView {
	// MARK: - Properties
	private lazy var stack: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.backgroundColor = .clear
		stack.spacing = 2
		stack.distribution = .fillEqually
		stack.alignment = .fill
		stack.axis = .vertical
		return stack
	}()
	
	override var intrinsicContentSize: CGSize {
		return stack.intrinsicContentSize
	}
	
	private lazy var anglesDictionary: [Int : [[Angle]]] = {
		return createAnglesDictionary()
	}()
	
	private var clocks: [[ClockView]] = []
	private var duration: Double = 2
	private var lastNumber: Int?
	
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
			stack.bottomAnchor.constraint(equalTo: bottomAnchor),
			stack.topAnchor.constraint(equalTo: topAnchor),
		])
		
		for _ in 0..<6 {
			var row: [ClockView] = []
			
			let rowStack = UIStackView()
			rowStack.backgroundColor = .clear
			rowStack.alignment = .fill
			rowStack.distribution = .fillEqually
			rowStack.spacing = 2
			rowStack.axis = .horizontal
			
			for _ in 0..<4 {
				let clockView = ClockView()
				clockView.translatesAutoresizingMaskIntoConstraints = false
				
				NSLayoutConstraint.activate([
					clockView.heightAnchor.constraint(equalTo: clockView.widthAnchor)
				])
				
				row.append(clockView)
				rowStack.addArrangedSubview(clockView)
			}
			
			stack.addArrangedSubview(rowStack)
			clocks.append(row)
		}
	}
	
	// MARK: - Methods
	func redraw() {
		for r in clocks {
			for i in r {
				i.redraw()
			}
		}
	}
	
	func animate(to number: Int, duration: Double) {
		guard number != lastNumber else { return }
		self.lastNumber = number
		self.duration = duration
		
		guard let angles = anglesDictionary[number] else { return }
		
		for i in 0..<clocks.count {
			for j in 0..<clocks[i].count {
				let angle = angles[i][j].Angle
				clocks[i][j].animate(index: 0, duration: duration, theta: angle.first)
				clocks[i][j].animate(index: 1, duration: duration, theta: angle.last)
			}
		}
	}
}

// MARK: - Create Angles
extension ClocksView {
	private func createAnglesDictionary() -> [Int : [[Angle]]] {
		var anglesDictionary: [Int : [[Angle]]] = [:]
		
		// 0
		let zero: [[Angle]] = [
			[.right2Bottom, .right2Left, .right2Left, .left2Bottom],
			[.top2Bottom, .bottom2Right, .left2Bottom, .top2Bottom],
			[.top2Bottom, .top2Bottom, .top2Bottom, .top2Bottom],
			[.top2Bottom, .top2Bottom, .top2Bottom, .top2Bottom],
			[.top2Bottom, .top2Right, .left2Top, .top2Bottom],
			[.top2Right, .left2Right, .left2Right, .left2Top],
		]
		
		anglesDictionary[0] = zero
		
		// 1
		let one: [[Angle]] = [
			[.bottom2Right, .left2Right, .left2Bottom, .none],
			[.top2Right, .left2Bottom, .top2Bottom, .none],
			[.none, .top2Bottom, .top2Bottom, .none],
			[.none, .top2Bottom, .top2Bottom, .none],
			[.right2Bottom, .left2Top, .top2Right, .left2Bottom],
			[.top2Right, .left2Right, .left2Right, .left2Top],
		]
		
		anglesDictionary[1] = one
		
		
		// 2
		let two: [[Angle]] = [
			[.bottom2Right, .left2Right, .left2Right, .left2Bottom],
			[.top2Right, .left2Right, .left2Bottom, .top2Bottom],
			[.bottom2Right, .left2Right, .left2Top, .top2Bottom],
			[.bottom2Top, .bottom2Right, .left2Right, .left2Top],
			[.bottom2Top, .top2Right, .left2Right, .left2Bottom],
			[.top2Right, .left2Right, .left2Right, .left2Top],
		]
		
		anglesDictionary[2] = two
		
		// 3
		let three: [[Angle]] = [
			[.bottom2Right, .left2Right, .left2Right, .left2Bottom],
			[.top2Right, .left2Right, .left2Bottom, .top2Bottom],
			[.bottom2Right, .left2Right, .left2Top, .top2Bottom],
			[.top2Right, .left2Right, .left2Bottom, .top2Bottom],
			[.bottom2Right, .left2Right, .left2Top, .top2Bottom],
			[.top2Right, .left2Right, .left2Right, .left2Top],
		]
		
		anglesDictionary[3] = three
		
		// 4
		let four: [[Angle]] = [
			[.bottom2Right, .left2Bottom, .bottom2Right, .left2Bottom],
			[.top2Bottom, .top2Bottom, .top2Bottom, .top2Bottom],
			[.top2Bottom, .top2Right, .left2Top, .top2Bottom],
			[.top2Right, .left2Right, .left2Bottom, .top2Bottom],
			[.none, .none, .top2Bottom, .top2Bottom],
			[.none, .none, .top2Right, .left2Top],
		]
		
		anglesDictionary[4] = four
		
		// 5
		let five: [[Angle]] = [
			[.bottom2Right, .left2Right, .left2Right, .left2Bottom],
			[.top2Bottom, .bottom2Right, .left2Right, .left2Top],
			[.top2Bottom, .top2Right, .left2Right, .left2Bottom],
			[.top2Right, .left2Right, (.left2Bottom), .top2Bottom],
			[.bottom2Right, .left2Right, .left2Top, .top2Bottom],
			[.top2Right, .left2Right, .left2Right, .left2Top],
		]
		
		anglesDictionary[5] = five
		
		// 6
		let six: [[Angle]] = [
			[.bottom2Right, .left2Right, .left2Right, .left2Bottom],
			[.top2Bottom, .bottom2Right, .left2Right, .left2Top],
			[.top2Bottom, .top2Right, .left2Right, .left2Bottom],
			[.top2Bottom, .bottom2Right, .left2Bottom, .top2Bottom],
			[.top2Bottom, .top2Right, .left2Top, .top2Bottom],
			[.top2Right, .left2Right, .left2Right, .left2Top],
		]
		
		anglesDictionary[6] = six
		
		// 7
		let seven: [[Angle]] = [
			[.bottom2Right, .left2Right, .left2Right, .left2Bottom],
			[.top2Right, .left2Right, .left2Bottom, .bottom2Top],
			[.none, .none, .top2Bottom, .bottom2Top],
			[.none, .none, .top2Bottom, .top2Bottom],
			[.none, .none, .top2Bottom, .top2Bottom],
			[.none, .none, .top2Right, .left2Top],
		]
		
		anglesDictionary[7] = seven
		
		// 8
		let eight: [[Angle]] = [
			[.bottom2Right, .left2Right, .left2Right, .left2Bottom],
			[.top2Bottom, .bottom2Right, .left2Bottom, .top2Bottom],
			[.top2Bottom, .top2Right, .left2Top, .top2Bottom],
			[.top2Bottom, .bottom2Right, .left2Bottom, .top2Bottom],
			[.top2Bottom, .top2Right, .left2Top, .top2Bottom],
			[.top2Right, .left2Right, .left2Right, .left2Top],
		]
		
		anglesDictionary[8] = eight
		
		// nine
		let nine: [[Angle]] = [
			[.bottom2Right, .left2Right, .left2Right, .left2Bottom],
			[.top2Bottom, .bottom2Right, .left2Bottom, .bottom2Top],
			[.top2Bottom, .top2Right, .left2Top, .bottom2Top],
			[.top2Right, .left2Right, .left2Bottom, .bottom2Top],
			[.bottom2Right, .left2Right, .left2Top, .bottom2Top],
			[.top2Right, .left2Right, .left2Right, .left2Top],
		]
		
		anglesDictionary[9] = nine
		
		return anglesDictionary
	}
}
