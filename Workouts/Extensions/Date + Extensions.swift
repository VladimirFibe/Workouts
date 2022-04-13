//
//  Date + Extensions.swift
//  Workouts
//
//  Created by Vladimir Fibe on 08.04.2022.
//

import Foundation

extension Date {
  func localDate() -> Date {
    let timeZoneOffset = Int(TimeZone.current.secondsFromGMT(for: self))
    let localDate = Calendar.current.date(byAdding: .second, value: timeZoneOffset, to: self) ?? Date()
    return localDate
  }
  
  func getWeekday() -> Int {
    Calendar.current.component(.weekday, from: self)
  }
  
  func startEndDate() -> (Date, Date) {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd"
//    formatter.timeZone = TimeZone(abbreviation: "UTC")
    let calendar = Calendar.current
    let day = calendar.component(.day, from: self)
    let month = calendar.component(.month, from: self)
    let year = calendar.component(.year, from: self)
    let dateStart = (formatter.date(from: "\(year)/\(month)/\(day)") ?? Date()).localDate()
    let dateEnd: Date = {
      let components = DateComponents(day: 1)
      return Calendar.current.date(byAdding: components, to: dateStart) ?? Date()
    }()
    return (dateStart, dateEnd)
  }
  
  func offsetDays(_ days: Int) -> Date {
    Calendar.current.date(byAdding: .day, value: -days, to: self) ?? Date()
  }
  
  func offsetMonth(_ month: Int) -> Date {
    Calendar.current.date(byAdding: .month, value: -month, to: self) ?? Date()
  }
  
  func getWeekArray() -> [Days] {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_GB")
    formatter.dateFormat = "EEEEEE"
    
    var days: [Days] = []
    let calendar = Calendar.current
    for index in -6...0 {
      let date = calendar.date(byAdding: .weekday, value: index, to: self) ?? Date()
      let day = calendar.component(.day, from: date)
      let weekday = formatter.string(from: date)
      days.append(Days(week: weekday, day: "\(day)"))
    }
    return days
  }
  
}

struct Days {
  var week = "DD"
  var day = "00"
}
