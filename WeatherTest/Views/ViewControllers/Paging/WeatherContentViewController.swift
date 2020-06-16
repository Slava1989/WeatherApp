//
//  WeatherContentViewController.swift
//  WeatherTest
//
//  Created by Veaceslav Chirita on 6/17/20.
//  Copyright © 2020 Veaceslav Chirita. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherContentViewController: UIViewController, WeatherPageVCDelegate, CLLocationManagerDelegate {
    var weatherPageVC: WeatherPageViewController?
    var locationManager: CLLocationManager!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func updateUI() {
        if let index = weatherPageVC?.currentIndex {
            pageControl.currentPage = index
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
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
