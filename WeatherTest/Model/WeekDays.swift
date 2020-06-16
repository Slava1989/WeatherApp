//
//  WeekDays.swift
//  WeatherTest
//
//  Created by Veaceslav Chirita on 6/16/20.
//  Copyright © 2020 Veaceslav Chirita. All rights reserved.
//

import Foundation

enum WeekDays: Int {
    case Sunday
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
    
    var dayOfWeek: String {
        switch self {
        case .Sunday:
            return "Sunday"
        case .Monday:
            return "Monday"
        case .Tuesday:
            return "Tuesday"
        case .Wednesday:
            return "Wednesday"
        case .Thursday:
            return "Thursday"
        case .Friday:
            return "Friday"
        case .Saturday:
            return "Saturday"
        }
    }
}
