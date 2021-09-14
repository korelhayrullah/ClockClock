//
//  ClockView.swift
//  ClockClock
//
//  Created by Korel Hayrullah on 12.09.2021.
//

import UIKit

class ClockView: UIView {
	// MARK: - Properties
	private let overlay: CAShapeLayer = CAShapeLayer()
	
	private let models: [ClockViewComponents] = {
		return [
			ClockViewComponents(),
			ClockViewComponents()
		]
	}()
	
	var overlayWidth: CGFloat = 1 {
		didSet {
			setNeedsDisplay()
		}
	}
	
	var lineWidth: CGFloat = 2 {
		didSet {
			setNeedsDisplay()
		}
	}
	
	var lineColor: UIColor {
		if #available(iOS 13, *) {
			return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
				if UITraitCollection.userInterfaceStyle == .dark {
					return Settings.darkModeLineColor
				}
				
				return Settings.lightModeLineColor
			}
		} else {
			return Settings.lightModeLineColor
		}
	}
	
	// MARK: - Init
	override init(frame: CGRect) {
		super.init(frame: frame)
		initialize()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		initialize()
	}
	
	private func initialize() {
		var degs = Array(stride(from: CGFloat(0), to: 360, by: 15))
		
		for model in models {
			guard let rand = degs.randomElement() else { break }
			
			model.initialDegree = rand
			model.lastDegree = rand
			
			if let index = degs.firstIndex(of: rand) {
				degs.remove(at: index)
			}
		}
		
		setNeedsDisplay()
	}
	
	// MARK: - Methods
	override func draw(_ rect: CGRect) {
		let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
		let radius = (rect.width / 2) - (lineWidth / 2)
		
		drawOverlay(
			center: center,
			radius: radius
		)
		
		for model in models {
			drawLine(
				model.line,
				center: center,
				radius: radius * 0.75,
				theta: model.initialDegree
			)
		}
	}
	
	private func drawLine(_ line: CAShapeLayer,
												center: CGPoint,
												radius: CGFloat,
												theta: CGFloat) {
		let path = UIBezierPath()
		path.move(to: center)
		
		let rads = Math.deg2Rad(theta)
		let x = radius * cos(rads) + center.x
		let y = radius * sin(rads) + center.y
		
		path.addLine(to: CGPoint(x: x, y: y))
		
		line.lineWidth = lineWidth
		line.strokeColor = lineColor.cgColor
		line.path = path.cgPath
		line.lineCap = .round
		line.frame = bounds
		
		if line.superlayer == nil {
			layer.addSublayer(line)
		}
	}
	
	private func drawOverlay(center: CGPoint, radius: CGFloat) {
		let path = UIBezierPath(
			arcCenter: center,
			radius: radius,
			startAngle: 0,
			endAngle: 2 * .pi,
			clockwise: true
		)
		
		overlay.lineWidth = overlayWidth
		overlay.strokeColor = UIColor.gray.cgColor
		overlay.fillColor = UIColor.clear.cgColor
		overlay.path = path.cgPath
		
		if overlay.superlayer == nil {
			layer.addSublayer(overlay)
		}
	}
	
	func redraw() {
		setNeedsDisplay()
	}

	func animate(index: Int, duration: Double, theta: CGFloat) {
		guard 0 <= index && index < models.count else { return }
		let model = models[index]
		model.line.removeAllAnimations()
		
		let anim = CABasicAnimation(keyPath: "transform.rotation.z")
		anim.duration = duration
		anim.isRemovedOnCompletion = false
		anim.fillMode = .forwards
		anim.fromValue = Math.deg2Rad(model.lastDegree)
		anim.toValue = Math.deg2Rad(theta - model.initialDegree)
		
		model.lastDegree = theta - model.initialDegree
		model.line.add(anim, forKey: "transform-rotation-animation-\(index)")
	}
}
