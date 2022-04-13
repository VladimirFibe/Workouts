//
//  User.swift
//  Workouts
//
//  Created by Vladimir Fibe on 13.04.2022.
//

import Foundation
import RealmSwift

class User: Object {
  @Persisted var firstname = "Alisa"
  @Persisted var lastname = "Selezneva"
  @Persisted var height = 100
  @Persisted var weight = 50
  @Persisted var target = 0
  @Persisted var image: Data?
}
