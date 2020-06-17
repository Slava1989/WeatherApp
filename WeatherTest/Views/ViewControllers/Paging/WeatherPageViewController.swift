//
//  WeatherPageViewController.swift
//  WeatherTest
//
//  Created by Veaceslav Chirita on 6/17/20.
//  Copyright © 2020 Veaceslav Chirita. All rights reserved.
//

import UIKit
import CoreLocation

protocol WeatherPageVCDelegate: class {
    func didUpdatePageIndex(currentIndex: Int)
}

class WeatherPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, CLLocationManagerDelegate {
    
    weak var walkthroughDelegate: WeatherPageVCDelegate?
    var locations: [CLLocationCoordinate2D]!
    var currentIndex = 0
    var locationManager: CLLocationManager!
    var isAppended = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        locationManager = CLLocationManager()
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        locations = [
            CLLocationCoordinate2D(latitude: 64.1834700, longitude: -51.7215700),
            CLLocationCoordinate2D(latitude: 31.2222200, longitude: 121.4580600),
            CLLocationCoordinate2D(latitude: 12.2222200, longitude: 121.4580600)
        ]
        
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        if !isAppended {
            self.locations.append(
                CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
            )
            isAppended = true
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WeatherViewController).index
        index -= 1
        
        return contentViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WeatherViewController).index
        index += 1
        
        return contentViewController(at: index)
    }
    
    func contentViewController(at index: Int) -> WeatherViewController? {
        if index < 0 || index >= locations.count {
            return nil
        }
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let pageContentViewController = storyBoard.instantiateViewController(withIdentifier: "WeatherViewController") as? WeatherViewController {
            pageContentViewController.cityLocation = locations[index]
            pageContentViewController.index = index
            
            return pageContentViewController
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let contentVC = pageViewController.viewControllers?.first as? WeatherViewController {
                currentIndex = contentVC.index
                walkthroughDelegate?.didUpdatePageIndex(currentIndex: currentIndex)
            }
        }
    }
}
