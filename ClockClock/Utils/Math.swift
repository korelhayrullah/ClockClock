//
//  Math.swift
//  ClockClock
//
//  Created by Korel Hayrullah on 12.09.2021.
//

import CoreGraphics

enum Math {
	static func rad2Deg(_ rad: CGFloat) -> CGFloat {
		return (rad / .pi) * 180
	}
	
	static func deg2Rad(_ deg: CGFloat) -> CGFloat {
		return (.pi / 180) * deg
	}
}
