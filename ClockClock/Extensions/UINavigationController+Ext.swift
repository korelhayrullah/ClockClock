//
//  UINavigationController+Ext.swift
//  ClockClock
//
//  Created by Korel Hayrullah on 14.09.2021.
//

import UIKit

extension UINavigationController {
	var rootViewController: UIViewController? {
		return children.first
	}
}
