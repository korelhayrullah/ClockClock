//
//  ViewController.swift
//  ClockClock
//
//  Created by Korel Hayrullah on 12.09.2021.
//

import UIKit

class ViewController: UIViewController {
	// MARK: - Properties
	private let clockClockView: ClockClockView = ClockClockView()
	private var timer: Timer?
	
	// MARK: - Methods
	override func viewDidLoad() {
		super.viewDidLoad()
		configureUI()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		startTimer()
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		stopTimer()
	}
	
	private func configureUI() {
		view.addSubview(clockClockView)
		clockClockView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			clockClockView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			clockClockView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		])
	}
	
	// MARK: - Timer
	private func startTimer() {
		clockClockView.update()
		
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
		clockClockView.update()
	}
}
