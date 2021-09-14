//
//  SettingsViewController.swift
//  ClockClock
//
//  Created by Korel Hayrullah on 14.09.2021.
//

import UIKit

class SettingsViewController: UITableViewController {
	// MARK: - Properties
	@IBOutlet
	private weak var animationDurationLabel: UILabel!
	
	@IBOutlet
	private weak var darkModeLineColorView: UIView!
	
	@IBOutlet
	private weak var lightModeLineColorView: UIView!
	
	var dismissed: (() -> Void)?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		update()
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		dismissed?()
	}
	
	private func update() {
		animationDurationLabel.text = "\(Settings.animationDuration)"
		darkModeLineColorView.backgroundColor = Settings.darkModeLineColor
		lightModeLineColorView.backgroundColor = Settings.lightModeLineColor
	}
	
	// MARK: - Methods
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		switch indexPath.row {
		case 0:
			presentAnimationDurationAlert { [weak self] duration in
				Settings.animationDuration = duration
				self?.update()
			}
		case 1:
			presentColorSelectionController(selected: Settings.darkModeLineColor, completion: { [weak self] color in
				Settings.needsRedraw = Settings.darkModeLineColor != color
				Settings.darkModeLineColor = color
				self?.update()
			})
		case 2:
			presentColorSelectionController(selected: Settings.lightModeLineColor, completion: { [weak self] color in
				Settings.needsRedraw = Settings.lightModeLineColor != color
				Settings.lightModeLineColor = color
				self?.update()
			})
		default:
			break
		}
	}
	
	private func presentColorSelectionController(selected: UIColor, completion: @escaping (UIColor) -> Void) {
		let identifier = "ColorSelectionViewControllerNavigationController"
		guard let nav = UIStoryboard.instantiateViewController(identifier: identifier) as? UINavigationController else { return }
		guard let controller = nav.rootViewController as? ColorSelectionViewController else { return }
		controller.selectedColor = selected
		controller.completion = completion
		present(nav, animated: true, completion: nil)
	}
	
	// MARK: - Actions
	@IBAction
	private func resetButtonPressed(_ sender: UIButton) {
		Settings.reset()
		update()
	}
}

// MARK: - Alerts
extension SettingsViewController {
	private func presentAnimationDurationAlert(completion: @escaping (Double) -> Void) {
		let alert = UIAlertController(title: "Animation Duration",
																	message: nil,
																	preferredStyle: .alert)
		
		alert.addTextField { tf in
			tf.textAlignment = .center
			tf.keyboardType = .numberPad
		}
		
		let apply = UIAlertAction(title: "Set", style: .default, handler: { [weak self] _ in
			guard let text = alert.textFields?.first?.text else { return }
			
			guard let number = Double(text) else {
				self?.presentErrorAlert(message: "Entered text is not a number!")
				return
			}
			
			guard number > 0 else {
				self?.presentErrorAlert(message: "Entered number must be greater than 0 and a non-negative number!")
				return
			}
			
			completion(number)
		})
		
		let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		
		alert.addAction(apply)
		alert.addAction(cancel)
		present(alert, animated: true, completion: nil)
	}
	
	private func presentErrorAlert(message: String) {
		let alert = UIAlertController(
			title: "Error",
			message: message,
			preferredStyle: .alert
		)
		
		let confirm = UIAlertAction(title: "Ok", style: .default, handler: nil)
		alert.addAction(confirm)
		present(alert, animated: true, completion: nil)
	}
}
