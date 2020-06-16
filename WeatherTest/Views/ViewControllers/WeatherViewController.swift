//
//  ViewController.swift
//  WeatherTest
//
//  Created by Veaceslav Chirita on 6/16/20.
//  Copyright © 2020 Veaceslav Chirita. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa
import CoreLocation
import MapKit

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet private weak var dailyUITableView: UITableView!
    @IBOutlet private weak var hoursCollectionView: UICollectionView!
    @IBOutlet private weak var cityNameLabel: UILabel!
    @IBOutlet private weak var weatherLabel: UILabel!
    @IBOutlet private weak var temperatureBigLabel: UILabel!
    @IBOutlet private weak var dayOfWeekLabel: UILabel!
    @IBOutlet private weak var dayNightLabel: UILabel!
    
    let viewModel = WeatherViewModel()
    let dis = DisposeBag()
    var index = 0
    var cityLocation: CLLocationCoordinate2D!
    let gradientLayer = CAGradientLayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hoursCollectionView.delegate = self
        dailyUITableView.register(UINib(nibName: "DailyTableViewCell", bundle: nil), forCellReuseIdentifier: "DailyTableViewCell")
        
        
        viewModel.requestAPI(lat: cityLocation.latitude, long: cityLocation.longitude, isHourly: true)
        viewModel.requestAPI(lat: cityLocation.latitude, long: cityLocation.longitude, isHourly: false)
        
        viewModel.currentPeriodOfDay.asObservable().bind { (periodString) in
            DispatchQueue.main.async {
                self.dayNightLabel.text = periodString
                if periodString == "Night" {
                    self.setGradientBackgroundForNight()
                } else {
                    self.setGradientBackgroundForDay()
                }
            }
        }.disposed(by: dis)
        
        viewModel.currentDayOfWeek.asObservable().bind { (dayOfWeek) in
            DispatchQueue.main.async {
                self.dayOfWeekLabel.text = dayOfWeek
            }
        }.disposed(by: dis)
        
        viewModel.currentCityData.asObservable().bind { (cityData) in
            DispatchQueue.main.async {
                self.cityNameLabel.text = String((cityData?.timezone.split(separator: "/")[1]) ?? "City")
                self.temperatureBigLabel.text = "\(Int(round(cityData?.current.temp ?? 273) - 273))°"
                self.weatherLabel.text = cityData?.current.weather[0].main
            }
        }.disposed(by: dis)
        
        viewModel.weatherHourly.asObservable().bind(to: hoursCollectionView.rx.items(cellIdentifier: "HoursCollectionViewCell", cellType: HoursCollectionViewCell.self)) { [unowned self] (row: Int, model: HourlyWeather?, cell: HoursCollectionViewCell) in
            
            if row == 0 {
                cell.hoursLabel.text = "Now"
            } else {
                cell.hoursLabel.text = self.viewModel.getTime(index: row)
            }
            cell.temperatureLabel.text = "\(Int(round(model!.temp - 273)))°"
            let symbol = self.viewModel.getWeatherSymbol(value: model?.weather[0].main ?? "")
            cell.weatherSymbolLabel.text = symbol
            
            cell.updateUI(for: self.dayNightLabel.text!)
        }.disposed(by: dis)
        
        viewModel.weatherDaily.asObservable().bind(to: dailyUITableView.rx.items(cellIdentifier: "DailyTableViewCell", cellType: DailyTableViewCell.self)) { [unowned self] (row: Int, model:
            DailyWeather?, cell: DailyTableViewCell) in
            
            cell.weekDayLabel.text       = self.viewModel.getDayOfWeek(from: TimeInterval(model!.dt))
            cell.weatherSymbolLabel.text = self.viewModel.getWeatherSymbol(value: model!.weather[0].main)
            cell.firstTemperatureLabel.text  = "\(Int(round(model!.temp.day - 273)))"
            cell.secondTemperatureLabel.text = "\(Int(round(model!.temp.night - 273)))"
            
            cell.updateUI(for: self.dayNightLabel.text!)
        
            
        }.disposed(by: dis)
        
    }
}

extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 120)
    }
}
