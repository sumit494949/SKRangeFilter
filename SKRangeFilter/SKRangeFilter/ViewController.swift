//
//  ViewController.swift
//  SKRangeFilter
//
//  Created by Sumit Kumar on 2/4/23.
//

import UIKit

class ViewController: UIViewController, SKRangeFilterDelegate {


    var rangeFilter:SKRangeFilter!
    override func viewDidLoad() {
        super.viewDidLoad()
        rangeFilter = SKRangeFilter(frame: CGRect(x: 0, y: 60, width: self.view.bounds.width, height: 320))
//        rangeFilter.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rangeFilter)
        rangeFilter.titleLabelText = "Price Range"
        rangeFilter.delegate = self
        
        // Do any additional setup after loading the view.
    }

    

}

