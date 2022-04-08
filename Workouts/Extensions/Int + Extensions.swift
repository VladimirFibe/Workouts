//
//  Int + Extensions.swift
//  Workouts
//
//  Created by Vladimir Fibe on 08.04.2022.
//

import Foundation

extension Int {
  func converSeconds() -> (Int, Int) {
    (self / 60, self % 60)
  }
  
  func setZeroForSeconds() -> String {
    self < 10 ? "0\(self)" : "\(self)"
  }
  
  func stringFromSeconds() -> String {
    let (min, sec) = self.converSeconds()
    return sec == 0 ? "\(min) min" : "\(min) min \(sec) sec"
  }
  
  func labelFromSecond() -> String {
    let (min, sec) = self.converSeconds()
    return "\(min):\(sec.setZeroForSeconds())"
  }
}
