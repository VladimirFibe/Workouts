//
//  RepsOrTimerView.swift
//  Workouts
//
//  Created by Vladimir Fibe on 09.04.2022.
//
import SwiftUI
import UIKit

class RepsOrTimerView: UIView {
  private let setView = WorkoutSliderView()
  private let repsView = WorkoutSliderView()
  private let timerView = WorkoutSliderView()
  private let repeatOrTimerLabel = UILabel().then {
    $0.text = "Choose repeat or timer"
    $0.font = .robotoMedium18()
    $0.textColor = .specialLightBrown
    $0.textAlignment = .center
  }
  func addTargets() {
    setView.slider.addTarget(self, action: #selector(setsSliderChanged), for: .valueChanged)
    repsView.slider.addTarget(self, action: #selector(repsSliderChanged), for: .valueChanged)
    timerView.slider.addTarget(self, action: #selector(timerSliderChanged), for: .valueChanged)
  }
  
  func resetValues() {
    setView.configure(title: "Set", min: 0, max: 10)
    repsView.configure(title: "Reps", min: 0, max: 50)
    timerView.configure(title: "Timer", min: 0, max: 600)
    timerView.setNegative()
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
    addTargets()
    resetValues()
    let stack = UIStackView(arrangedSubviews: [setView, repeatOrTimerLabel, repsView, timerView], axis: .vertical)
    addSubview(stack)
    stack.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 15, paddingRight: 15)
  }
  
  @objc func setsSliderChanged() {
    setView.setValueLabel()
  }

  @objc func repsSliderChanged() {
    repsView.setValueLabel()
    if timerView.titleLabel.alpha == 1 {
      timerView.setNegative()
    }
    if repsView.titleLabel.alpha < 1 {
      repsView.setActive()
    }
  }

  @objc func timerSliderChanged() {
    timerView.setValueLabel()
    if repsView.titleLabel.alpha == 1 {
      repsView.setNegative()
    }
    if timerView.titleLabel.alpha < 1 {
      timerView.setActive()
    }
  }

  func getSet() -> Int{
    Int(setView.slider.value)
  }
  func getReps() -> Int{
    Int(repsView.slider.value)
  }
  func getTimer() -> Int{
    Int(timerView.slider.value)
  }
}

struct RepsOrTimerView_Previews: PreviewProvider {
  static var previews: some View {
    SwiftUINewWorkoutViewController()
      .edgesIgnoringSafeArea(.all)
  }
}

