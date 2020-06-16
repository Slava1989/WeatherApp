//
//  ViewController.swift
//  WeatherTest
//
//  Created by Veaceslav Chirita on 6/16/20.
//  Copyright © 2020 Veaceslav Chirita. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var hoursCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        hoursCollectionView.register(UINib(nibName: "HoursCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HoursCollectionViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setGradientBackground()
    }
}



