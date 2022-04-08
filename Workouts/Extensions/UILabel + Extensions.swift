//
//  UILabel + Extensions.swift
//  Workouts
//
//  Created by Vladimir Fibe on 08.04.2022.
//

import UIKit

extension UILabel {
  convenience init(_ title: String = "") {
    self.init()
    text = title
    font = .robotoMedium14()
    textColor = .specialLightBrown
  }
}
