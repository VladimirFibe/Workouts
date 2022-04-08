//
//  Workout.swift
//  Workouts
//
//  Created by Vladimir Fibe on 08.04.2022.
//

import Foundation
import RealmSwift

class Workout: Object {
  @Persisted var date: Date
  @Persisted var days = 0
  @Persisted var name = "Unknow"
  @Persisted var repeats = true
  @Persisted var sets = 0
  @Persisted var reps = 0
  @Persisted var timer = 0
  @Persisted var image: Data?
  @Persisted var status = false
}
