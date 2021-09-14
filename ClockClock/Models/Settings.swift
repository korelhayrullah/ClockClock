//
//  Settings.swift
//  ClockClock
//
//  Created by Korel Hayrullah on 14.09.2021.
//

import Foundation

enum Settings {
	static var current: SettingsModel = .preset
	static var needsRedraw: Bool = false
	
	static func reset() {
		current = .preset
		needsRedraw = true
	}
}




