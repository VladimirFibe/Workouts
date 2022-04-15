//
//  Onboarding.swift
//  Workouts
//
//  Created by Vladimir Fibe on 14.04.2022.
//

import Foundation

struct Onboarding {
  let top: String
  let bottom: String
  let image: String
  
  static let all = [Onboarding(top: "Have a good health",
                               bottom: "Being healthy is all, no health is nothing. So why do not we",
                               image: "onboarding1"),
                    Onboarding(top: "Be stronger",
                               bottom: "Take 30 minutes of bodybuilding every day to get physically fit and healthy.",
                               image: "onboarding2"),
                    Onboarding(top: "Have nice body",
                               bottom: "Bad body shape, poor sleep, lack of strength, weight gain, weak bones, easily traumatized body, depressed, stressed, poor metabolism, poor resistance",
                               image: "onboarding3")]
}
