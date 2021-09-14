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
	
	@IBOutlet
	private var saveBarButtonItem: UIBarButtonItem!
	
	private var mutableSettings: SettingsModelMutable = SettingsModelMutable(model: Settings.current)
	
	var dismissed: (() -> Void)?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureUI()
		update()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		darkModeLineColorView.layer.cornerRadius = darkModeLineColorView.frame.height / 2
		lightModeLineColorView.layer.cornerRadius = lightModeLineColorView.frame.height / 2
	}
	
	private func configureUI() {
		darkModeLineColorView.layer.borderWidth = 0.5
		darkModeLineColorView.layer.borderColor = UIColor.black.cgColor
		
		lightModeLineColorView.layer.borderWidth = 0.5
		lightModeLineColorView.layer.borderColor = UIColor.black.cgColor
	}
	
	private func update() {
		animationDurationLabel.text = "\(mutableSettings.animationDuration)s"
		darkModeLineColorView.backgroundColor = mutableSettings.darkModeLineColor
		lightModeLineColorView.backgroundColor = mutableSettings.lightModeLineColor
		
		
		let hasChanges = Settings.current != SettingsModel(model: mutableSettings)
		navigationItem.rightBarButtonItems = hasChanges ? [saveBarButtonItem] : []
	}
	
	// MARK: - Methods
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		switch indexPath.row {
		case 0:
			presentAnimationDurationAlert { [weak self] duration in
				self?.mutableSettings.animationDuration = duration
				self?.update()
			}
		case 1:
			presentColorSelectionController(selected: mutableSettings.darkModeLineColor, completion: { [weak self] color in
				guard let self = self else { return }
				Settings.needsRedraw = self.mutableSettings.darkModeLineColor != color
				self.mutableSettings.darkModeLineColor = color
				self.update()
			})
		case 2:
			presentColorSelectionController(selected: mutableSettings.lightModeLineColor, completion: { [weak self] color in
				guard let self = self else { return }
				Settings.needsRedraw = self.mutableSettings.lightModeLineColor != color
				self.mutableSettings.lightModeLineColor = color
				self.update()
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
		let alert = UIAlertController(title: "Reset", message: "Are you sure you want to reset your settings?", preferredStyle: .actionSheet)
		
		let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		
		let reset = UIAlertAction(title: "Reset", style: .destructive) { [weak self] _ in
			self?.mutableSettings = SettingsModelMutable(model: .preset)
			self?.update()
		}
		
		alert.addAction(reset)
		alert.addAction(cancel)
		present(alert, animated: true, completion: nil)
	}
	
	@IBAction
	private func closeBarButtonItemPressed(_ sender: UIBarButtonItem) {
		dismiss(animated: true, completion: { [weak self] in
			self?.dismissed?()
		})
	}
	
	@IBAction
	private func saveBarButtonItemPressed(_ sender: UIBarButtonItem) {
		Settings.current = SettingsModel(model: mutableSettings)
		dismiss(animated: true, completion: { [weak self] in
			self?.dismissed?()
		})
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
