//
//  WorkoutSliderView.swift
//  Workouts
//
//  Created by Vladimir Fibe on 09.04.2022.
//

import UIKit

class WorkoutSliderView: UIView {
  let titleLabel = UILabel().then {
    $0.font = .robotoMedium18()
    $0.textColor = .specialGray
  }
  
  let valueLabel = UILabel().then {
    $0.font = .robotoMedium18()
    $0.textColor = .specialGray
  }
  
  let slider = UISlider().then {
    $0.maximumTrackTintColor = .specialLightBrown
    $0.minimumTrackTintColor = .specialGreen
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureUI() {
    translatesAutoresizingMaskIntoConstraints = false
    heightAnchor.constraint(equalToConstant: 64).isActive = true
    let labelsStack = UIStackView(arrangedSubviews: [titleLabel, valueLabel], axis: .horizontal)
    labelsStack.distribution = .equalSpacing
    let stack = UIStackView(arrangedSubviews: [labelsStack, slider], axis: .vertical)
    addSubview(stack)
    stack.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor)
  }
  
  func configure(title: String, min: Float, max: Float) {
    titleLabel.text = title
    slider.minimumValue = min
    slider.maximumValue = max
    slider.value = min
    valueLabel.text = titleLabel.text == "Timer" ? Int(min).stringFromSeconds() : String(Int(min))
  }
  
  func setValueLabel() {
    valueLabel.text = titleLabel.text == "Timer" ? Int(slider.value).stringFromSeconds() : String(Int(slider.value))
  }
  
  func setActive() {
    titleLabel.alpha = 1
    valueLabel.alpha = 1
    slider.alpha = 1
  }
  
  func setNegative() {
    titleLabel.alpha = 0.5
    valueLabel.alpha = 0.5
    valueLabel.text = titleLabel.text == "Timer" ? "0 min" : "0"
    slider.alpha = 0.5
    slider.value = 0
  }
}
