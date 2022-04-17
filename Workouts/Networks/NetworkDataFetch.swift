//
//  NetworkDataFetch.swift
//  Workouts
//
//  Created by Vladimir Fibe on 15.04.2022.
//

import Foundation

class NetworkDataFetch {
  static let shared = NetworkDataFetch()
  private init() {}
  func fetchWeather(completion: @escaping (WeatherModel?, Error?) -> Void) {
    NetworkRequest.shared.requestData { result in
      switch result {
      case .success(let data):
        do {
          let weather = try JSONDecoder().decode(WeatherModel.self, from: data)
          completion(weather, nil)
        } catch {
          print(error.localizedDescription)
          completion(nil, error)
        }
      case .failure(let error):
        print(error.localizedDescription)
        completion(nil, error)
      }
    }
  }
}
