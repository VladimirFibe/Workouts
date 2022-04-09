//
//  RepsOrTimerView.swift
//  Workouts
//
//  Created by Vladimir Fibe on 09.04.2022.
//
import SwiftUI
import UIKit

class RepsOrTimerView: UIView {
  
  private let setsLabel = UILabel().then {
    $0.text = "Sets"
    $0.font = .robotoMedium18()
    $0.textColor = .specialGray
  }
  
  private let numberOfSetLabel = UILabel().then {
    $0.text = "0"
    $0.font = .robotoMedium18()
    $0.textColor = .specialGray
  }
  
  let setsSlider = UISlider().then {
    $0.minimumValue = 0
    $0.maximumValue = 10
    $0.maximumTrackTintColor = .specialLightBrown
    $0.minimumTrackTintColor = .specialGreen
    $0.addTarget(nil, action: #selector(setsSliderChanged), for: .valueChanged)
  }
  
  private let repeatOrTimerLabel = UILabel().then {
    $0.text = "Choose repeat or timer"
    $0.font = .robotoMedium18()
    $0.textColor = .specialLightBrown
    $0.textAlignment = .center
  }
  
  private let repsLabel = UILabel().then {
    $0.text = "Reps"
    $0.font = .robotoMedium18()
    $0.textColor = .specialGray
  }
  
  private let numberOfRepsLabel = UILabel().then {
    $0.text = "0"
    $0.font = .robotoMedium18()
    $0.textColor = .specialGray
  }
  
  let repsSlider = UISlider().then {
    $0.minimumValue = 0
    $0.maximumValue = 50
    $0.maximumTrackTintColor = .specialLightBrown
    $0.minimumTrackTintColor = .specialGreen
    $0.addTarget(nil, action: #selector(repsSliderChanged), for: .valueChanged)
  }
  
  private let timerLabel = UILabel().then {
    $0.text = "Timer"
    $0.font = .robotoMedium18()
    $0.textColor = .specialGray
  }
  
  private let numblerOfTimerLabel = UILabel().then {
    $0.text = "0 min"
    $0.font = .robotoMedium18()
    $0.textColor = .specialGray
  }
  
  let timerSlider = UISlider().then {
    $0.minimumValue = 0
    $0.maximumValue = 600
    $0.maximumTrackTintColor = .specialLightBrown
    $0.minimumTrackTintColor = .specialGreen
    $0.addTarget(nil, action: #selector(timerSliderChanged), for: .valueChanged)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureUI() {
    backgroundColor = .specialBrown
    layer.cornerRadius = 10
    let setsStack = UIStackView(arrangedSubviews: [setsLabel, numberOfSetLabel], axis: .horizontal, spacing: 10)
    let repsStack = UIStackView(arrangedSubviews: [repsLabel, numberOfRepsLabel], axis: .horizontal, spacing: 10)
    let timerStack = UIStackView(arrangedSubviews: [timerLabel, numblerOfTimerLabel], axis: .horizontal, spacing: 10)
    
    addSubview(setsStack)
    addSubview(setsSlider)
    addSubview(repeatOrTimerLabel)
    addSubview(repsStack)
    addSubview(repsSlider)
    addSubview(timerStack)
    addSubview(timerSlider)
    
    setsStack.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 20, paddingLeft: 15, paddingRight: 15)
    setsSlider.anchor(top: setsStack.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 15, paddingRight: 15)
    repeatOrTimerLabel.anchor(top: setsSlider.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 20, paddingLeft: 15, paddingRight: 15)
    repsStack.anchor(top: repeatOrTimerLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 15, paddingRight: 15)
    repsSlider.anchor(top: repsStack.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 15, paddingRight: 15)
    timerStack.anchor(top: repsSlider.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 20, paddingLeft: 15, paddingRight: 15)
    timerSlider.anchor(top: timerStack.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 15, paddingRight: 15)
  }
  
  @objc func setsSliderChanged() {
    numberOfSetLabel.text = String(Int(setsSlider.value))
  }
  
  @objc func repsSliderChanged() {
    numberOfRepsLabel.text = String(Int(repsSlider.value))
    if timerLabel.alpha == 1 {
      setNegative(label: timerLabel, numberLabel: numblerOfTimerLabel, slider: timerSlider)
    }
    if repsLabel.alpha < 1 {
      setActive(label: repsLabel, numberLabel: numberOfRepsLabel, slider: repsSlider)
    }
  }
  
  @objc func timerSliderChanged() {
    numblerOfTimerLabel.text = Int(timerSlider.value).stringFromSeconds()
    if repsLabel.alpha == 1 {
      setNegative(label: repsLabel, numberLabel: numberOfRepsLabel, slider: repsSlider)
    }
    if timerLabel.alpha < 1 {
      setActive(label: timerLabel, numberLabel: numblerOfTimerLabel, slider: timerSlider)
    }
  }
  
  private func setActive(label: UILabel, numberLabel: UILabel, slider: UISlider) {
    label.alpha = 1
    numberLabel.alpha = 1
    slider.alpha = 1
  }
  
  private func setNegative(label: UILabel, numberLabel: UILabel, slider: UISlider) {
    label.alpha = 0.5
    numberLabel.alpha = 0.5
    numberLabel.text = "0"
    slider.alpha = 0.5
    slider.value = 0
  }
  
  func refreshValues() {
    numberOfSetLabel.text = "0"
    numberOfRepsLabel.text = "0"
    numblerOfTimerLabel.text = "0"
    timerSlider.value = 0
    repsSlider.value = 0
    setsSlider.value = 0
  }
}

struct RepsOrTimerView_Previews: PreviewProvider {
  static var previews: some View {
    SwiftUINewWorkoutViewController()
      .edgesIgnoringSafeArea(.all)
  }
}
