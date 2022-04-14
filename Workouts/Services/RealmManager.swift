//
//  RealmManager.swift
//  Workouts
//
//  Created by Vladimir Fibe on 08.04.2022.
//

import Foundation
import RealmSwift

class RealmManager {
  static let shared = RealmManager()
  private init() {}
  
  let localRealm = try! Realm()
  
  func save(_ model: Workout) {
    try! localRealm.write {
      localRealm.add(model)
    }
  }

    
  func update(_ model: Workout) {
    try! localRealm.write {
      model.status = true
    }
  }
  
  func update(_ model: Workout, sets: Int, reps: Int, timer: Int) {
    try! localRealm.write {
      if sets > 0 { model.sets = sets }
      if timer > 0 { model.timer = timer }
      if reps > 0 { model.reps = reps }
    }
  }
  
  func delete(_ model: Workout) {
    try! localRealm.write {
      localRealm.delete(model)
    }
  }
  
  func save(_ user: User) {
    let users = localRealm.objects(User.self)
    try! localRealm.write {
      if users.isEmpty {
        localRealm.add(user)
      } else {
        let first = users[0]
        first.firstname = user.firstname
        first.lastname = user.lastname
        first.height = user.height
        first.weight = user.weight
        first.target = user.target
        first.image = user.image
      }
    }
  }
}
