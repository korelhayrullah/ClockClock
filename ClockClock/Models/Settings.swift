//
//  Settings.swift
//  ClockClock
//
//  Created by Korel Hayrullah on 14.09.2021.
//

import UIKit

enum Settings {
	static var animationDuration: Double = 2
	static var darkModeLineColor: UIColor = .white
	static var lightModeLineColor: UIColor = .black
	static var needsRedraw: Bool = false
	
	static func reset() {
		animationDuration = 2
		darkModeLineColor = .white
		lightModeLineColor = .black
		needsRedraw = true
	}
}
