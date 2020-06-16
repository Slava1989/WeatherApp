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

class WeatherPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    weak var walkthroughDelegate: WeatherPageVCDelegate?
    var locations: [CLLocationCoordinate2D]!
    var currentIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        locations = [
            CLLocationCoordinate2D(latitude: 47.00556, longitude: 28.8575),
            CLLocationCoordinate2D(latitude: 31.2222200, longitude: 121.4580600),
            CLLocationCoordinate2D(latitude: 12.2222200, longitude: 121.4580600)
        ]
        
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
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
//            pageContentViewController.signImage = sign
            
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
