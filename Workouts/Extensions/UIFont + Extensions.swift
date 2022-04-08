//
//  UIFont + Extensions.swift
//  Workouts
//
//  Created by Vladimir Fibe on 08.04.2022.
//

import UIKit

//for family in UIFont.familyNames.sorted() {
//  let names = UIFont.fontNames(forFamilyName: family)
//  print(family, names)
//}

extension UIFont {
  
  //label.font = UIFont(name: "Roboto-Medium", size: 24)
  
  //Medium
  static func robotoMedium24() -> UIFont? {
    return UIFont.init(name: "Roboto-Medium", size: 24)
  }
  
  static func robotoMedium12() -> UIFont? {
    return UIFont.init(name: "Roboto-Medium", size: 12)
  }
  
  static func robotoMedium14() -> UIFont? {
    return UIFont.init(name: "Roboto-Medium", size: 14)
  }
  
  static func robotoMedium16() -> UIFont? {
    return UIFont.init(name: "Roboto-Medium", size: 16)
  }
  
  static func robotoMedium18() -> UIFont? {
    return UIFont.init(name: "Roboto-Medium", size: 18)
  }
  
  static func robotoMedium22() -> UIFont? {
    return UIFont.init(name: "Roboto-Medium", size: 22)
  }
  //Bold
  static func robotoBold16() -> UIFont? {
    return UIFont.init(name: "Roboto-Bold", size: 16)
  }
  
  static func robotoBold20() -> UIFont? {
    return UIFont.init(name: "Roboto-Bold", size: 20)
  }
  
  static func robotoBold48() -> UIFont? {
    return UIFont.init(name: "Roboto-Bold", size: 48)
  }
}
