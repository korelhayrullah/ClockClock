//
//  UIColor+Ext.swift
//  ClockClock
//
//  Created by Korel Hayrullah on 14.09.2021.
//

import UIKit

extension UIColor {
	convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
		self.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
	}
	
	var redComponent: CGFloat {
		var val: CGFloat = 0
		getRed(&val, green: nil, blue: nil, alpha: nil)
		return val
	}
	
	var greenComponent: CGFloat {
		var val: CGFloat = 0
		getRed(nil, green: &val, blue: nil, alpha: nil)
		return val
	}
	
	var blueComponent: CGFloat {
		var val: CGFloat = 0
		getRed(nil, green: nil, blue: &val, alpha: nil)
		return val
	}
}
