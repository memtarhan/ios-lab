//
//  ViewController.swift
//  PriceSlider
//
//  Created by Mehmet Tarhan on 06/07/2023.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let slider = RangeSliderView(frame: CGRect(x: 20, y: view.frame.height / 2, width: view.frame.width - 40, height: 64),
                                     lowestBound: 10,
                                     defaultLowerValue: 10,
                                     highestBound: 100,
                                     defaultHigherValue: 100)

        view.addSubview(slider)
    }
}

extension ViewController: RangeSliderDelegate {
    func rangeSlider(didUpdateLower value: CGFloat) {
        print(value)
    }

    func rangeSlider(didUpdateUpper value: CGFloat) {
        print(value)
    }
}
