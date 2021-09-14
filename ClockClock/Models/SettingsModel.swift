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
	let lineWidth: CGFloat
	let outlineWidth: CGFloat
	
	let darkModeLineColor: UIColor
	let darkModeOutlineColor: UIColor
	
	let lightModeLineColor: UIColor
	let lightModeOutlineColor: UIColor
	
	// MARK: - Init
	init(animationDuration: Double = 2,
			 lineWidth: CGFloat = 2,
			 outlineWidth: CGFloat = 1,
			 darkModeLineColor: UIColor = .white,
			 darkModeOutlineColor: UIColor = .darkGray,
			 lightModeLineColor: UIColor = .black,
			 lightModeOutlineColor: UIColor = .darkGray) {
		self.animationDuration = animationDuration
		self.lineWidth = lineWidth
		self.outlineWidth = outlineWidth
		self.darkModeLineColor = darkModeLineColor
		self.darkModeOutlineColor = darkModeOutlineColor
		self.lightModeLineColor = lightModeLineColor
		self.lightModeOutlineColor = lightModeOutlineColor
	}
	
	init(model: SettingsModelMutable) {
		self.animationDuration = model.animationDuration
		self.lineWidth = model.lineWidth
		self.outlineWidth = model.outlineWidth
		self.darkModeLineColor = model.darkModeLineColor
		self.darkModeOutlineColor = model.darkModeOutlineColor
		self.lightModeLineColor = model.lightModeLineColor
		self.lightModeOutlineColor = model.lightModeOutlineColor
	}
}

// MARK: - Default
extension SettingsModel {
	static var preset: SettingsModel = SettingsModel()
}

struct SettingsModelMutable {
	// MARK: - Properties
	var animationDuration: Double
	var lineWidth: CGFloat
	var outlineWidth: CGFloat
	
	var darkModeLineColor: UIColor
	var darkModeOutlineColor: UIColor
	
	var lightModeLineColor: UIColor
	var lightModeOutlineColor: UIColor
	
	// MARK: - Init
	init(model: SettingsModel = .preset) {
		self.animationDuration = model.animationDuration
		self.lineWidth = model.lineWidth
		self.outlineWidth = model.outlineWidth
		self.darkModeLineColor = model.darkModeLineColor
		self.darkModeOutlineColor = model.darkModeOutlineColor
		self.lightModeLineColor = model.lightModeLineColor
		self.lightModeOutlineColor = model.lightModeOutlineColor
	}
}
