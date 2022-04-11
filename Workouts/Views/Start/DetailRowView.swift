//
//  DetailRowView.swift
//  Workouts
//
//  Created by Vladimir Fibe on 11.04.2022.
//

import UIKit
import SwiftUI
class DetailRowView: UIView {
  private let nameLabel = UILabel().then {
    $0.text = "Time of Set"
    $0.font = .robotoMedium18()
    $0.textColor = .specialGray
  }
  private let valueLabel = UILabel().then {
    $0.text = "59 min 59 sec"
    $0.font = .robotoMedium24()
    $0.textColor = .specialGray
    $0.textAlignment = .right
  }
  private let divider = UIView().then {
    $0.backgroundColor = .specialLine
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  func configureUI() {
    heightAnchor.constraint(equalToConstant: 35).isActive = true
    let stackLabel = UIStackView(arrangedSubviews: [nameLabel, valueLabel],
                            axis: .horizontal)
    stackLabel.alignment = .fill
    stackLabel.distribution = .equalSpacing
    let stack = UIStackView(arrangedSubviews: [stackLabel, divider], axis: .vertical, spacing: 0)
    addSubview(stack)
    stack.anchor(top: topAnchor,
                 left: leftAnchor,
                 right: rightAnchor)
    divider.anchor(height: 1)
  }
  func configureWith(name: String, value: String) {
    nameLabel.text = name
    valueLabel.text = value
  }
}

struct DetailRowView_Previews: PreviewProvider {
  static var previews: some View {
    SwiftUIStartViewController()
      .edgesIgnoringSafeArea(.all)
  }
}
