//
//  WeatherModel.swift
//  Workouts
//
//  Created by Vladimir Fibe on 15.04.2022.
//

import Foundation

// MARK: - WeatherModel
struct WeatherModel: Codable {
  let coord: Coord
  let weather: [Weather]
  let base: String
  let main: Main
  let visibility: Int
  let wind: Wind
  let rain: Rain
  let clouds: Clouds
  let dt: Int
  let sys: Sys
  let timezone, id: Int
  let name: String
  let cod: Int
}

// MARK: - Clouds
struct Clouds: Codable {
  let all: Int
}

// MARK: - Coord
struct Coord: Codable {
  let lon, lat: Int
}

// MARK: - Main
struct Main: Codable {
  let temp, feelsLike, tempMin, tempMax: Double
  let pressure, humidity: Int
  
  enum CodingKeys: String, CodingKey {
    case temp
    case feelsLike = "feels_like"
    case tempMin = "temp_min"
    case tempMax = "temp_max"
    case pressure, humidity
  }
}

// MARK: - Rain
struct Rain: Codable {
  let the1H: Double
  
  enum CodingKeys: String, CodingKey {
    case the1H = "1h"
  }
}

// MARK: - Sys
struct Sys: Codable {
  let type, id: Int
  let country: String
  let sunrise, sunset: Int
}

// MARK: - Weather
struct Weather: Codable {
  let id: Int
  let main, weatherDescription, icon: String
  
  enum CodingKeys: String, CodingKey {
    case id, main
    case weatherDescription = "description"
    case icon
  }
}

// MARK: - Wind
struct Wind: Codable {
  let speed: Double
  let deg: Int
  let gust: Double
}
