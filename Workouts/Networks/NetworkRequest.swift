//
//  NetworkRequest.swift
//  Workouts
//  Created by Vladimir Fibe on 15.04.2022.
// https://app.quicktype.io
// http://openweathermap.org/img/wn/10d@2x.png

import Foundation

class NetworkRequest {
  static let shared = NetworkRequest()
  private init() {}
  
  func requestData(completion: @escaping(Result<Data, Error>) -> Void) {
    let key = "46958494d92dddd02f6d0e45932fa84f"
    let latitude = 35
    let longitude = 139
    let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(key)&units=metric"
    guard let url = URL(string: urlString) else { return }
    URLSession.shared.dataTask(with: url) { data, response, error in
      DispatchQueue.main.async {
        if let error = error {
          completion(.failure(error))
          return
        }
        guard let data = data else { return }
        completion(.success(data))
      }
    }.resume()
  }
}
