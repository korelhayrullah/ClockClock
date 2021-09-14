//
//  SettingsModel.swift
//  ClockClock
//
//  Created by Korel Hayrullah on 14.09.2021.
//

import UIKit

struct SettingsModel: Equatable {
	// MARK: - Properties
	let animationDuration: Double
	let darkModeLineColor: UIColor
	let lightModeLineColor: UIColor
	
	// MARK: - Init
	init(animationDuration: Double = 2,
			 darkModeLineColor: UIColor = .white,
			 lightModeLineColor: UIColor = .black) {
		self.animationDuration = animationDuration
		self.darkModeLineColor = darkModeLineColor
		self.lightModeLineColor = lightModeLineColor
	}
	
	init(model: SettingsModelMutable) {
		self.animationDuration = model.animationDuration
		self.darkModeLineColor = model.darkModeLineColor
		self.lightModeLineColor = model.lightModeLineColor
	}
}

// MARK: - Default
extension SettingsModel {
	static var preset: SettingsModel = SettingsModel()
}

struct SettingsModelMutable {
	// MARK: - Properties
	var animationDuration: Double
	var darkModeLineColor: UIColor
	var lightModeLineColor: UIColor
	
	// MARK: - Init
	init(model: SettingsModel = .preset) {
		self.animationDuration = model.animationDuration
		self.darkModeLineColor = model.darkModeLineColor
		self.lightModeLineColor = model.lightModeLineColor
	}
}
