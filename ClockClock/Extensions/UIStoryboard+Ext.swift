//
//  UIStoryboard+Ext.swift
//  ClockClock
//
//  Created by Korel Hayrullah on 14.09.2021.
//

import UIKit

extension UIStoryboard {
	class func instantiateViewController(storyboard: String = "Main", identifier: String) -> UIViewController {
		let storyboard = UIStoryboard(name: storyboard, bundle: .main)
		return storyboard.instantiateViewController(identifier: identifier)
	}
}
