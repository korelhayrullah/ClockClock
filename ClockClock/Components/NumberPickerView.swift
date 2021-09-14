//
//  NumberPickerView.swift
//  ClockClock
//
//  Created by Korel Hayrullah on 14.09.2021.
//

import UIKit

class NumberPickerView: UIView {
	private let picker: UIPickerView = UIPickerView()
	private(set) var numbers: [Int] = []
	
	var selected: Int?
	
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
		backgroundColor = .clear
		addSubview(picker)
		
		picker.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			picker.leadingAnchor.constraint(equalTo: leadingAnchor),
			picker.trailingAnchor.constraint(equalTo: trailingAnchor),
			picker.topAnchor.constraint(equalTo: topAnchor),
			picker.bottomAnchor.constraint(equalTo: bottomAnchor),
		])
		
		picker.delegate = self
		picker.dataSource = self
	}
	
	func set(_ numbers: [Int]) {
		self.numbers = numbers
		picker.reloadAllComponents()
	}
	
	func select(_ number: Int) {
		if let index = numbers.firstIndex(where: { $0 == number }) {
			picker.selectRow(index, inComponent: 0, animated: false)
			selected = numbers[index]
		}
	}
}

// MARK: - UIPickerViewDelegate
extension NumberPickerView: UIPickerViewDelegate {
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return "\(numbers[row])"
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		selected = numbers[row]
	}
}

// MARK: - UIPickerViewDataSource
extension NumberPickerView: UIPickerViewDataSource {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return numbers.count
	}
}
