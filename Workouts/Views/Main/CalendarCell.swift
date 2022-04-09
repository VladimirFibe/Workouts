//
//  CalendarCell.swift
//  Workouts
//
//  Created by Vladimir Fibe on 09.04.2022.
//

import UIKit

class CalendarCell: UICollectionViewCell {
  private let weekLabel = UILabel().then {
    $0.text = "WE"
    $0.font = .robotoBold16()
    $0.textColor = .white
    $0.textAlignment = .center
  }
  
  private let dayLabel = UILabel().then {
    $0.text = "29"
    $0.font = .robotoBold20()
    $0.textColor = .white
    $0.textAlignment = .center
  }
  
  override var isSelected: Bool {
    didSet {
      if self.isSelected {
        backgroundColor = .specialYellow
        weekLabel.textColor = .specialBlack
        dayLabel.textColor = .specialDarkGreen
      } else {
        backgroundColor = .clear
        weekLabel.textColor = .white
        dayLabel.textColor = .white
      }
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(with day: Days) {
    weekLabel.text = day.week
    dayLabel.text = day.day
  }
  
  func configureUI() {
    layer.cornerRadius = 10
    let stack = UIStackView(arrangedSubviews: [weekLabel, dayLabel], axis: .vertical, spacing: 5)
    stack.alignment = .center
    stack.distribution = .fillProportionally
    addSubview(stack)
    stack.center(inView: self)
  }
}
