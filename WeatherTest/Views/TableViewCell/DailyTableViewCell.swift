//
//  DailyTableViewCell.swift
//  WeatherTest
//
//  Created by Veaceslav Chirita on 6/16/20.
//  Copyright © 2020 Veaceslav Chirita. All rights reserved.
//

import UIKit

class DailyTableViewCell: UITableViewCell {

    @IBOutlet weak var weekDayLabel: UILabel!
    @IBOutlet weak var weatherSymbolLabel: UILabel!
    @IBOutlet weak var firstTemperatureLabel: UILabel!
    @IBOutlet weak var secondTemperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        weekDayLabel.text           = ""
        weatherSymbolLabel.text     = ""
        firstTemperatureLabel.text  = ""
        secondTemperatureLabel.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(for period: String) {
        if period == "Night" {
            weekDayLabel.textColor           = UIColor.white
            firstTemperatureLabel.textColor  = UIColor.white
            secondTemperatureLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5)
        } else {
            weekDayLabel.textColor           = UIColor.black
            firstTemperatureLabel.textColor  = UIColor.black
            secondTemperatureLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        }
    }
    
}
