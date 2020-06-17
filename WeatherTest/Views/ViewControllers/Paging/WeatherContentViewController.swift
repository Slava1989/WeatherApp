//
//  WeatherContentViewController.swift
//  WeatherTest
//
//  Created by Veaceslav Chirita on 6/17/20.
//  Copyright © 2020 Veaceslav Chirita. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherContentViewController: UIViewController, WeatherPageVCDelegate {
    var weatherPageVC: WeatherPageViewController?
    var locationManager: CLLocationManager!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    func updateUI() {
        if let index = weatherPageVC?.currentIndex {
            pageControl.currentPage = index
        }
    }
    
    func didUpdatePageIndex(currentIndex: Int) {
        updateUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let pageVC = destination as? WeatherPageViewController {
            weatherPageVC = pageVC
            weatherPageVC?.walkthroughDelegate = self
        }
    }
}
