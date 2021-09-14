//
//  ColorSelectionViewController.swift
//  ClockClock
//
//  Created by Korel Hayrullah on 14.09.2021.
//

import UIKit

class ColorSelectionViewController: UIViewController {
	// MARK: - Properties
	@IBOutlet
	private weak var previewView: UIView!
	
	@IBOutlet
	private weak var redSlider: UISlider!
	
	@IBOutlet
	private weak var greenSlider: UISlider!
	
	@IBOutlet
	private weak var blueSlider: UISlider!
	
	@IBOutlet
	private weak var previewInfoLabel: UILabel!
	var selectedColor: UIColor?
	var completion: ((UIColor) -> Void)?
	
	// MARK: - Methods
	override func viewDidLoad() {
		super.viewDidLoad()
		update(with: selectedColor, updatesSliderComponets: true)
	}
	
	// MARK: - Methods
	private func update(with color: UIColor?, updatesSliderComponets: Bool) {
		previewView.backgroundColor = color
		
		let r = (color?.redComponent ?? 0) * 255
		let g = (color?.greenComponent ?? 0) * 255
		let b = (color?.blueComponent ?? 0) * 255
		previewInfoLabel.text = "R: \(Int(r)), G: \(Int(g)), B: \(Int(b))"

		if updatesSliderComponets {
			redSlider.setValue(Float(r), animated: false)
			greenSlider.setValue(Float(b), animated: false)
			blueSlider.setValue(Float(b), animated: false)
		}
	}
	
	// MARK: - Actions
	@IBAction
	private func selectButtonPressed(_ sender: UIButton) {
		dismiss(animated: true, completion: { [weak self] in
			guard let color = self?.selectedColor else { return }
			self?.completion?(color)
		})
	}
	
	@IBAction
	private func sliderValueChanged(_ sender: UISlider) {
		let r = CGFloat(redSlider.value)
		let g = CGFloat(greenSlider.value)
		let b = CGFloat(blueSlider.value)
		
		let new = UIColor(red: r, green: g, blue: b)
		self.selectedColor = new
		update(with: new, updatesSliderComponets: false)
		
		// 0 -> Red
		// 1 -> Green
		// 2 -> Blue
		switch sender.tag {
		case 0:
			sender.minimumTrackTintColor = UIColor(red: CGFloat(sender.value), green: 0, blue: 0)
		case 1:
			sender.minimumTrackTintColor = UIColor(red: 0, green: CGFloat(sender.value), blue: 0)
		case 2:
			sender.minimumTrackTintColor = UIColor(red: 0, green: 0, blue: CGFloat(sender.value))
		default:
			break
		}
	}
}
