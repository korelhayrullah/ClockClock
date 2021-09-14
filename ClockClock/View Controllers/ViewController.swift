//
//  ViewController.swift
//  ClockClock
//
//  Created by Korel Hayrullah on 12.09.2021.
//

import UIKit

class ViewController: UIViewController {
	// MARK: - Properties
	@IBOutlet
	private weak var clockClockView: ClockClockView!
	
	@IBOutlet
	private weak var infoLabel: UILabel!
	
	override var prefersStatusBarHidden: Bool {
		return true
	}
	
	override var prefersHomeIndicatorAutoHidden: Bool {
		return true
	}
	
	private var isInitial: Bool = true
	
	// MARK: - Methods
	override func viewDidLoad() {
		super.viewDidLoad()
		setGestureRecognizer()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		UIApplication.shared.isIdleTimerDisabled = true
		
		clockClockView.start()
		
		if isInitial || Int.random(in: 0...100) <= 25 {
			animateInfoLabel()
			isInitial = false
		}
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		UIApplication.shared.isIdleTimerDisabled = false
		
		clockClockView.stop()
	}
	
	private func setGestureRecognizer() {
		let tap = UITapGestureRecognizer()
		tap.addTarget(self, action: #selector(tapGestureRecognizer(_:)))
		tap.numberOfTapsRequired = 2
		view.addGestureRecognizer(tap)
	}
	
	private func animateInfoLabel() {
		let animations: () -> Void = { [weak self] in
			UIView.addKeyframe(withRelativeStartTime: 0,relativeDuration: 0.2) {
				self?.infoLabel.alpha = 1
			}
			
			UIView.addKeyframe(withRelativeStartTime: 0.8,relativeDuration: 0.2) {
				self?.infoLabel.alpha = 0
			}
		}
		
		UIView.animateKeyframes(
			withDuration: 5,
			delay: 1,
			options: .calculationModeCubic,
			animations: animations,
			completion: nil
		)
	}
	
	// MARK: - Actions
	@objc
	private func tapGestureRecognizer(_ sender: UITapGestureRecognizer) {
		let identifier = "SettingsTableViewControllerNavigationController"
		guard let nav = UIStoryboard.instantiateViewController(identifier: identifier) as? UINavigationController else { return }
		guard let controller = nav.rootViewController as? SettingsViewController else { return }
		controller.dismissed = { [weak self] in
			if Settings.needsRedraw {
				Settings.needsRedraw = false
				self?.clockClockView.redraw()
			}
		}
		present(nav, animated: true, completion: nil)
	}
}
