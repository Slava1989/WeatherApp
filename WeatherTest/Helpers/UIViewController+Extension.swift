//
//  UIViewController+Extension.swift
//  WeatherTest
//
//  Created by Veaceslav Chirita on 6/16/20.
//  Copyright © 2020 Veaceslav Chirita. All rights reserved.
//

import UIKit

extension WeatherViewController {
    
    
    func setGradientBackgroundForNight() {
        var colorTop: CGColor
        var colorBottom: CGColor
        colorTop =  UIColor(red: 6.0/255.0, green: 6.0/255.0, blue: 11.0/255.0, alpha: 1.0).cgColor
        colorBottom = UIColor(red: 41.0/255.0, green: 45.0/255.0, blue: 56.0/255.0, alpha: 1.0).cgColor
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds

        self.view.layer.insertSublayer(gradientLayer, at:0)
        
        self.view.setNeedsLayout()
    }
    
    func setGradientBackgroundForDay() {
        var colorTop: CGColor
        var colorBottom: CGColor
        colorTop =  UIColor(red: 135.0/255.0, green: 206.0/255.0, blue: 235.0/255.0, alpha: 1.0).cgColor
        colorBottom = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 224.0/255.0, alpha: 1.0).cgColor
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds

        self.view.layer.insertSublayer(gradientLayer, at:0)
        
        self.view.setNeedsLayout()
    }
}
