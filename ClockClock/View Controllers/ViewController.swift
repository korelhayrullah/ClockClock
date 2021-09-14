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
	
	private var isInitial: Bool = true
	private var timer: Timer?
	
	override var prefersStatusBarHidden: Bool {
		return true
	}
	
	// MARK: - Methods
	override func viewDidLoad() {
		super.viewDidLoad()
		setGestureRecognizer()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		startTimer()
		
		UIApplication.shared.isIdleTimerDisabled = true
		
		if isInitial || Double.random(in: 0...1) < 0.3 {
			animateInfoLabel()
			isInitial = false
		}
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		stopTimer()
		
		UIApplication.shared.isIdleTimerDisabled = false
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
	
	// MARK: - Timer
	private func startTimer() {
		clockClockView.update(duration: Settings.animationDuration)
		
		timer = Timer.scheduledTimer(
			timeInterval: 1,
			target: self,
			selector: #selector(timerDidFire(_:)),
			userInfo: nil,
			repeats: true
		)
	}
	
	private func stopTimer() {
		timer?.invalidate()
		timer = nil
	}
	
	@objc
	private func timerDidFire(_ timer: Timer) {
		clockClockView.update(duration: Settings.animationDuration)
	}
}
