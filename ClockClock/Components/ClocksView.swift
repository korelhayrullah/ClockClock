//
//  ClocksView.swift
//  ClockClock
//
//  Created by Korel Hayrullah on 12.09.2021.
//

import UIKit

class ClocksView: UIView {
	// MARK: - Typealiases
	typealias Thetas = (first: CGFloat, last: CGFloat)
	
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
	
	private let none: Thetas = (135, 135)
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
					clockView.widthAnchor.constraint(equalToConstant: 30),
					clockView.heightAnchor.constraint(equalToConstant: 30)
				])
				
				row.append(clockView)
				rowStack.addArrangedSubview(clockView)
			}
			
			stack.addArrangedSubview(rowStack)
			clocks.append(row)
		}
	}
	
	// MARK: - Methods
	func animate(to number: Int, duration: Double = 2) {
		guard number != lastNumber else { return }
		self.lastNumber = number
		self.duration = duration
		
		switch number {
		case 0:
			setZero()
		case 1:
			setOne()
		case 2:
			setTwo()
		case 3:
			setThree()
		case 4:
			setFour()
		case 5:
			setFive()
		case 6:
			setSix()
		case 7:
			setSeven()
		case 8:
			setEight()
		case 9:
			setNine()
		default:
			break
		}
	}
	
	private func animate(with thetas: [[Thetas]]) {
		for i in 0..<clocks.count {
			for j in 0..<clocks[i].count {
				clocks[i][j].animate(index: 0, duration: duration, theta: thetas[i][j].first)
				clocks[i][j].animate(index: 1, duration: duration, theta: thetas[i][j].last)
			}
		}
	}
	
	private func setZero() {
		let thetas: [[Thetas]] = [
			[(0, 90), (0, 180), (0, 180), (180, 90)],
			[(270, 90), (90, 0), (180, 90), (270, 90)],
			[(270, 90), (270, 90), (270, 90), (270, 90)],
			[(270, 90), (270, 90), (270, 90), (270, 90)],
			[(270, 90), (270, 0), (180, 270), (270, 90)],
			[(270, 0), (180, 0), (180, 0), (180, 270)],
		]
		animate(with: thetas)
	}
	
	private func setOne() {
		let thetas: [[Thetas]] = [
			[(90, 0), (180, 0), (180, 90), none],
			[(270, 0), (180, 90), (270, 90), none],
			[none, (270, 90), (270, 90), none],
			[none, (270, 90), (270, 90), none],
			[(0, 90), (180, 270), (270, 0), (180, 90)],
			[(270, 0), (180, 0), (180, 0), (180, 270)],
		]
		
		animate(with: thetas)
	}
	
	private func setTwo() {
		let thetas: [[Thetas]] = [
			[(90, 0), (180, 0), (180, 0), (180, 90)],
			[(270, 0), (180, 0), (180, 90), (270, 90)],
			[(90, 0), (180, 0), (180, 270), (270, 90)],
			[(90, 270), (90, 0), (180, 0), (180, 270)],
			[(90, 270), (270, 0), (180, 0), (180, 90)],
			[(270, 0), (180, 0), (180, 0), (180, 270)],
		]
		
		animate(with: thetas)
	}
	
	private func setThree() {
		let thetas: [[Thetas]] = [
			[(90, 0), (180, 0), (180, 0), (180, 90)],
			[(270, 0), (180, 0), (180, 90), (270, 90)],
			[(90, 0), (180, 0), (180, 270), (270, 90)],
			[(270, 0), (180, 0), (180, 90), (270, 90)],
			[(90, 0), (180, 0), (180, 270), (270, 90)],
			[(270, 0), (180, 0), (180, 0), (180, 270)],
		]
		
		animate(with: thetas)
	}
	
	private func setFour() {
		let thetas: [[Thetas]] = [
			[(90, 0), (180, 90), (90, 0), (180, 90)],
			[(270, 90), (270, 90), (270, 90), (270, 90)],
			[(270, 90), (270, 0), (180, 270), (270, 90)],
			[(270, 0), (180, 0), (180, 90), (270, 90)],
			[none, none, (270, 90), (270, 90)],
			[none, none, (270, 0), (180, 270)],
		]
		
		animate(with: thetas)
	}
	
	private func setFive() {
		let thetas: [[Thetas]] = [
			[(90, 0), (180, 0), (180, 0), (180, 90)],
			[(270, 90), (90, 0), (180, 0), (180, 270)],
			[(270, 90), (270, 0), (180, 0), (180, 90)],
			[(270, 0), (180, 0), ((180, 90)), (270, 90)],
			[(90, 0), (180, 0), (180, 270), (270, 90)],
			[(270, 0), (180, 0), (180, 0), (180, 270)],
		]
		
		animate(with: thetas)
	}
	
	private func setSix() {
		let thetas: [[Thetas]] = [
			[(90, 0), (180, 0), (180, 0), (180, 90)],
			[(270, 90), (90, 0), (180, 0), (180, 270)],
			[(270, 90), (270, 0), (180, 0), (180, 90)],
			[(270, 90), (90, 0), (180, 90), (270, 90)],
			[(270, 90), (270, 0), (180, 270), (270, 90)],
			[(270, 0), (180, 0), (180, 0), (180, 270)],
		]
		
		animate(with: thetas)
	}
	
	private func setSeven() {
		let thetas: [[Thetas]] = [
			[(90, 0), (180, 0), (180, 0), (180, 90)],
			[(270, 0), (180, 0), (180, 90), (90, 270)],
			[none, none, (270, 90), (90, 270)],
			[none, none, (270, 90), (270, 90)],
			[none, none, (270, 90), (270, 90)],
			[none, none, (270, 0), (180, 270)],
		]
		
		animate(with: thetas)
	}
	
	private func setEight() {
		let thetas: [[Thetas]] = [
			[(90, 0), (180, 0), (180, 0), (180, 90)],
			[(270, 90), (90, 0), (180, 90), (270, 90)],
			[(270, 90), (270, 0), (180, 270), (270, 90)],
			[(270, 90), (90, 0), (180, 90), (270, 90)],
			[(270, 90), (270, 0), (180, 270), (270, 90)],
			[(270, 0), (180, 0), (180, 0), (180, 270)],
		]
		
		animate(with: thetas)
	}
	
	private func setNine() {
		let thetas: [[Thetas]] = [
			[(90, 0), (180, 0), (180, 0), (180, 90)],
			[(270, 90), (90, 0), (180, 90), (90, 270)],
			[(270, 90), (270, 0), (180, 270), (90, 270)],
			[(270, 0), (180, 0), (180, 90), (90, 270)],
			[(90, 0), (180, 0), (180, 270), (90, 270)],
			[(270, 0), (180, 0), (180, 0), (180, 270)],
		]
		
		animate(with: thetas)
	}
}

