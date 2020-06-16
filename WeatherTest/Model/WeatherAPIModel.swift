//
//  WeatherAPIModel.swift
//  WeatherTest
//
//  Created by Veaceslav Chirita on 6/16/20.
//  Copyright © 2020 Veaceslav Chirita. All rights reserved.
//

import Foundation

struct WeatherAPIModel: Codable {
    var lat: Double
    var lon: Double
    var timezone: String
    var daily: [DailyWeather]?
    var hourly: [HourlyWeather]?
    var current: CurrentCity
}

struct CurrentCity: Codable {
    var temp: Double
    var weather: [Weather]
    var sunrise: Int
    var sunset: Int
}

struct DailyWeather: Codable {
    var dt: Int
    var temp: Temperature
    var weather: [Weather]
}

struct HourlyWeather: Codable {
    var dt: Int
    var temp: Double
    var weather: [Weather]
}

struct Weather: Codable {
    var main: String
    var icon: String
}

struct Temperature: Codable {
    var day: Double
    var min: Double
    var max: Double
    var night: Double
    var eve: Double
    var morn: Double
}
