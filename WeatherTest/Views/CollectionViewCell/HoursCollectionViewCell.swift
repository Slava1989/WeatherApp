//
//  HoursCollectionViewCell.swift
//  WeatherTest
//
//  Created by Veaceslav Chirita on 6/16/20.
//  Copyright © 2020 Veaceslav Chirita. All rights reserved.
//

import UIKit

class HoursCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var weatherSymbolLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func prepareForReuse() {
        hoursLabel.text = ""
        weatherSymbolLabel.text = ""
        temperatureLabel.text = ""
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        hoursLabel.textColor         = UIColor.white
        weatherSymbolLabel.textColor = UIColor.white
        temperatureLabel.textColor   = UIColor.white
    }
    
    func updateUI(for period: String) {
        if period == "Night" {
            hoursLabel.textColor       = UIColor.white
            temperatureLabel.textColor = UIColor.white
        } else {
            hoursLabel.textColor       = UIColor.black
            temperatureLabel.textColor = UIColor.black
        }
    }

}
