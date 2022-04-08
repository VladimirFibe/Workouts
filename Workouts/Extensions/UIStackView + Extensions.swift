//
//  UIStackView + Extensions.swift
//  Workouts
//
//  Created by Vladimir Fibe on 08.04.2022.
//

import UIKit

extension UIStackView {
  convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat = 10.0) {
    self.init(arrangedSubviews: arrangedSubviews)
    self.axis = axis
    self.spacing = spacing
    self.translatesAutoresizingMaskIntoConstraints = false
  }
}
