//
//  DateAndRepeatView.swift
//  Workouts
//
//  Created by Vladimir Fibe on 09.04.2022.
//
import SwiftUI
import UIKit

class DateAndRepeatView: UIView {
  private let dateLabel = UILabel().then {
    $0.text = "Date"
    $0.font = .robotoMedium18()
    $0.textColor = .specialGray
  }
  
  private let datePicker = UIDatePicker().then {
    $0.datePickerMode = .date
    $0.tintColor = .specialGreen
  }
  
  private let repeatLabel = UILabel().then {
    $0.text = "Repeat every 7 days"
    $0.font = .robotoMedium18()
    $0.textColor = .specialGray
  }
  
  private let repeatSwitch = UISwitch().then {
    $0.onTintColor = .specialGreen
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    resetValues()
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureUI() {
    backgroundColor = .specialBrown
    layer.cornerRadius = 10
    let dateStack = UIStackView(arrangedSubviews: [dateLabel, datePicker], axis: .horizontal)
    let repeatStack = UIStackView(arrangedSubviews: [repeatLabel, repeatSwitch], axis: .horizontal)
    let stack = UIStackView(arrangedSubviews: [dateStack, repeatStack], axis: .vertical)
    addSubview(stack)
    stack.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 15, paddingRight: 15)
  }
  
  func resetValues() {
    repeatSwitch.isOn = true
    datePicker.date = Date()
  }
  
  func getRepeat() -> Bool {
    repeatSwitch.isOn
  }
  
  func getDate() -> Date {
    datePicker.date
  }
}

struct DateAndRepeatView_Previews: PreviewProvider {
  static var previews: some View {
    SwiftUINewWorkoutViewController()
      .edgesIgnoringSafeArea(.all)
  }
}
