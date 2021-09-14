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
	private weak var lineWidthLabel: UILabel!
	
	@IBOutlet
	private weak var outlineWidthLabel: UILabel!
	
	@IBOutlet
	private weak var darkModeLineColorView: UIView!
	
	@IBOutlet
	private weak var darkModeOutlineColorView: UIView!
	
	@IBOutlet
	private weak var lightModeLineColorView: UIView!
	
	@IBOutlet
	private weak var lightModeOutlineColorView: UIView!
	
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
		
		let views: [UIView] = [
			darkModeLineColorView,
			darkModeOutlineColorView,
			lightModeLineColorView,
			lightModeOutlineColorView
		]
		
		views.forEach { view in
			view.layer.cornerRadius = view.frame.height / 2
		}
	}
	
	private func configureUI() {
		let views: [UIView] = [
			darkModeLineColorView,
			darkModeOutlineColorView,
			lightModeLineColorView,
			lightModeOutlineColorView
		]
		
		views.forEach { view in
			view.layer.borderWidth = 0.5
			view.layer.borderColor = UIColor.black.cgColor
		}
	}
	
	private func update() {
		animationDurationLabel.text = "\(mutableSettings.animationDuration)s"
		lineWidthLabel.text = "\(Int(mutableSettings.lineWidth))"
		outlineWidthLabel.text = "\(Int(mutableSettings.outlineWidth))"
		darkModeLineColorView.backgroundColor = mutableSettings.darkModeLineColor
		darkModeOutlineColorView.backgroundColor = mutableSettings.darkModeOutlineColor
		lightModeLineColorView.backgroundColor = mutableSettings.lightModeLineColor
		lightModeOutlineColorView.backgroundColor = mutableSettings.lightModeOutlineColor
		
		let hasChanges = Settings.current != SettingsModel(model: mutableSettings)
		navigationItem.rightBarButtonItems = hasChanges ? [saveBarButtonItem] : []
	}
	
	// MARK: - Methods
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		switch (indexPath.section, indexPath.row) {
		case (0, 0):
			presentAnimationDurationAlert { [weak self] duration in
				self?.mutableSettings.animationDuration = duration
				self?.update()
			}
		case (0, 1):
			let completion: (CGFloat) -> Void = { [weak self] lineWidth in
				guard let self = self else { return }
				
				Settings.needsRedraw = self.mutableSettings.lineWidth != lineWidth
				self.mutableSettings.lineWidth = lineWidth
				self.update()
			}
			
			presentNumberSelectionPickerAlert(
				title: "Select Line Width",
				selected: Int(mutableSettings.lineWidth),
				numbers: [1, 2, 3, 4, 5, 6],
				completion: completion
			)
		case (0, 2):
			let completion: (CGFloat) -> Void = { [weak self] lineWidth in
				guard let self = self else { return }
				
				Settings.needsRedraw = self.mutableSettings.outlineWidth != lineWidth
				self.mutableSettings.outlineWidth = lineWidth
				self.update()
			}
			
			presentNumberSelectionPickerAlert(
				title: "Select Outline Width",
				selected: Int(mutableSettings.outlineWidth),
				numbers: [1, 2, 3],
				completion: completion
			)
		case (1, 0):
			presentColorSelectionController(selected: mutableSettings.darkModeLineColor, completion: { [weak self] color in
				guard let self = self else { return }
				Settings.needsRedraw = self.mutableSettings.darkModeLineColor != color
				self.mutableSettings.darkModeLineColor = color
				self.update()
			})
		case (1, 1):
			presentColorSelectionController(selected: mutableSettings.darkModeOutlineColor, completion: { [weak self] color in
				guard let self = self else { return }
				Settings.needsRedraw = self.mutableSettings.darkModeOutlineColor != color
				self.mutableSettings.darkModeOutlineColor = color
				self.update()
			})
		case (2, 0):
			presentColorSelectionController(selected: mutableSettings.lightModeLineColor, completion: { [weak self] color in
				guard let self = self else { return }
				Settings.needsRedraw = self.mutableSettings.lightModeLineColor != color
				self.mutableSettings.lightModeLineColor = color
				self.update()
			})
		case (2, 1):
			presentColorSelectionController(selected: mutableSettings.lightModeOutlineColor, completion: { [weak self] color in
				guard let self = self else { return }
				Settings.needsRedraw = self.mutableSettings.lightModeOutlineColor != color
				self.mutableSettings.lightModeOutlineColor = color
				self.update()
			})
		default:
			break
		}
	}
	
	// MARK: - Actions
	@IBAction
	private func resetButtonPressed(_ sender: UIButton) {
		let alert = UIAlertController(
			title: "Reset",
			message: "Are you sure you want to reset your settings?",
			preferredStyle: .actionSheet
		)
		
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

// MARK: - Alerts and Presentations
extension SettingsViewController {
	private func presentNumberSelectionPickerAlert(title: String?, selected: Int? = nil, numbers: [Int], completion: @escaping (CGFloat) -> Void) {
		let alert = UIAlertController(
			title: title,
			message: "\n\n\n\n\n\n",
			preferredStyle: .alert
		)
		
		alert.isModalInPresentation = true
		
		let picker = NumberPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 140))
		picker.set(numbers)
		if let selected = selected {
			picker.select(selected)
		}
		
		alert.view.addSubview(picker)
		
		let select = UIAlertAction(title: "Select", style: .default, handler: { _ in
			guard let lineWidth = picker.selected else { return }
			completion(CGFloat(lineWidth))
		})
		
		let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		alert.addAction(select)
		alert.addAction(cancel)
		
		present(alert, animated: true, completion: nil)
	}
	
	private func presentColorSelectionController(selected: UIColor, completion: @escaping (UIColor) -> Void) {
		let identifier = "ColorSelectionViewControllerNavigationController"
		guard let nav = UIStoryboard.instantiateViewController(identifier: identifier) as? UINavigationController else { return }
		guard let controller = nav.rootViewController as? ColorSelectionViewController else { return }
		controller.selectedColor = selected
		controller.completion = completion
		present(nav, animated: true, completion: nil)
	}
	
	private func presentAnimationDurationAlert(completion: @escaping (Double) -> Void) {
		let alert = UIAlertController(
			title: "Animation Duration",
			message: nil,
			preferredStyle: .alert
		)
		
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
