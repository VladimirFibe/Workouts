//
//  StatisticCell.swift
//  Workouts
//
//  Created by Vladimir Fibe on 12.04.2022.
//

import UIKit

class StatisticCell: UITableViewCell {
  var workout = Workout()
  
  private let nameLabel = UILabel().then {
    $0.font = .robotoMedium24()
  }
  
  private let beforeLabel = UILabel().then {
    $0.font = .robotoMedium14()
    $0.textColor = .specialLightBrown
  }
  
  private let divider = UIView().then {
    $0.backgroundColor = .specialLine
  }

  private let valueLabel = UILabel().then {
    $0.font = .robotoMedium24()
  }
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(with model: Workout) {
    workout = model
    nameLabel.text = model.name
    beforeLabel.text = "Before: 18 Now: 20"
    valueLabel.text = "+2"
    valueLabel.textColor = .specialGreen
    
  }
  
  func configureUI() {
    backgroundColor = .clear
    let nameStack = UIStackView(arrangedSubviews: [nameLabel, beforeLabel], axis: .vertical, spacing: 1)
    let stack = UIStackView(arrangedSubviews: [nameStack, valueLabel], axis: .horizontal)
    addSubview(stack)
    stack.alignment = .fill
    stack.distribution = .equalSpacing
    addSubview(divider)
    stack.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor)
    divider.anchor(top: stack.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 3, height: 1)
  }
}
