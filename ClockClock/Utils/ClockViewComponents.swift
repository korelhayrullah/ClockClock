//
//  ClockViewComponents.swift
//  ClockClock
//
//  Created by Korel Hayrullah on 13.09.2021.
//

import UIKit

class ClockViewComponents {
	// MARK: - Properties
	let line: CAShapeLayer
	var initialDegree: CGFloat = 0
	var lastDegree: CGFloat = 0 
	
	// MARK: - Init
	init() {
		self.line = CAShapeLayer()
		lastDegree = 0
	}
}
