//
//  ClocksView+Angle.swift
//  ClockClock
//
//  Created by Korel Hayrullah on 14.09.2021.
//

import Foundation
import CoreGraphics

extension ClocksView {
	enum Angle {
		// defined as default position
		case none
		
		// horizontal
		case left2Right
		case right2Left
		
		// vertical
		case top2Bottom
		case bottom2Top
		
		// left - top
		case left2Top
		case top2Left
		
		// right - top
		case top2Right
		case right2Top
		
		// right - bottom
		case right2Bottom
		case bottom2Right
		
		// left - bottom
		case bottom2Left
		case left2Bottom
		
		
		var Angle: (first: CGFloat, last: CGFloat) {
			switch self {
			case .none:
				return (135, 135)
			case .left2Right:
				return (180, 0)
			case .right2Left:
				return (0, 180)
			case .top2Bottom:
				return (270, 90)
			case .bottom2Top:
				return (90, 270)
			case .left2Top:
				return (180, 270)
			case .top2Left:
				return (270, 180)
			case .top2Right:
				return (270, 0)
			case .right2Top:
				return (0, 270)
			case .right2Bottom:
				return (0, 90)
			case .bottom2Right:
				return (90, 0)
			case .bottom2Left:
				return (90, 180)
			case .left2Bottom:
				return (180, 90)
			}
		}
	}
}

