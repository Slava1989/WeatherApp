//
//  WeatherViewModel.swift
//  WeatherTest
//
//  Created by Veaceslav Chirita on 6/16/20.
//  Copyright © 2020 Veaceslav Chirita. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift
import RxRelay

class WeatherViewModel {
    let disposeBag = DisposeBag()
    
    public let weatherDaily: BehaviorRelay<[DailyWeather?]> = BehaviorRelay(value: [])
    public let weatherHourly: BehaviorRelay<[HourlyWeather?]> = BehaviorRelay(value: [])
    public let currentCityData: BehaviorRelay<WeatherAPIModel?> = BehaviorRelay(value: nil)
    public let currentDayOfWeek: BehaviorRelay<String> = BehaviorRelay(value: "Monday")
    public let currentPeriodOfDay: BehaviorRelay<String> = BehaviorRelay(value: "Night")
    
    private var currentDate: Date!
    
    init() {
        currentDate = Date()
        currentDayOfWeek.accept(getDayOfWeek())
    }

    func requestAPI(lat: CLLocationDegrees, long: CLLocationDegrees, isHourly: Bool) {
        ApiNetwork.shared.getWeather(lat: lat, long: long, isHourly: isHourly) { [unowned self] (responseModel) in
            
            self.currentCityData.accept(responseModel)
            
            if isHourly {
                var hoursModel = [HourlyWeather]()
                for index in 0..<(48 - self.getCurrentTime() - 24) {
                    hoursModel.append(responseModel!.hourly![index])
                }
                
                self.weatherHourly.accept(hoursModel)
            } else {
                self.weatherDaily.accept(responseModel!.daily!)
            }
            
            self.currentPeriodOfDay.accept(self.getPeriodOfDay(sunsetTime: responseModel?.current.sunset,
                           sunriseTime: responseModel?.current.sunrise))
        }
    }
    
    func getWeatherSymbol(value: String) -> String {
        switch value {
        case "Rain":
            return WeatherSymbols.Rain.rawValue
        case "Clear":
            return WeatherSymbols.Clear.rawValue
        case "Clouds":
            return WeatherSymbols.Clouds.rawValue
        case "Thunderstorm":
            return WeatherSymbols.Thunderstorm.rawValue
        case "Snow":
            return WeatherSymbols.Snow.rawValue
        case "Mist":
            return WeatherSymbols.Mist.rawValue
        default:
            return ""
        }
    }
    
    func getPeriodOfDay(sunsetTime: Int?, sunriseTime: Int?) -> String {
        guard let sunsetTime = sunsetTime, let sunriseTime = sunriseTime else {
            return ""
        }
        
        let sunsetDate = Date(timeIntervalSince1970: TimeInterval(sunsetTime))
        let sunriseDate = Date(timeIntervalSince1970: TimeInterval(sunriseTime))
        
        if currentDate >= sunriseDate && currentDate < sunsetDate {
            return "Day"
        }
        
        return "Night"
        
    }
    
    func getTime(index: Int) -> String {
        let remainder = (getCurrentTime() + index) % 12
        let result = (getCurrentTime() + index) / 12
        var timeString = ""
        
        if remainder == 0 {
            timeString += "12"
        } else {
            timeString += "\(remainder)"
        }
        
        if result == 0 || result == 2 {
            timeString += " AM"
        } else {
            timeString += " PM"
        }
        
        return timeString
    }
    
    func getCurrentTime() -> Int {
        let calendar = Calendar.current
        return calendar.component(.hour, from: currentDate)
    }
    
    func getTime(from date: Date) -> Int {
        let calendar = Calendar.current
        return calendar.component(.hour, from: date)
    }
    
    func getDayOfWeek() -> String {
        let calendar = Calendar.current
        let dayOfWeek = WeekDays.init(rawValue: calendar.component(.weekday, from: currentDate) - 1)
        return dayOfWeek!.dayOfWeek
    }
    
    func getDayOfWeek(from timeStamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeStamp)
        let calendar = Calendar.current
        let dayOfWeek = WeekDays.init(rawValue: calendar.component(.weekday, from: date) - 1)
        return dayOfWeek!.dayOfWeek
    }
}
