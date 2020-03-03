//
//  CanIBuyResultsViewController.swift
//  Simple Home Calculator
//
//  Created by Wyatt Harrell on 3/2/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit

class CanIBuyResultsViewController: UIViewController {

    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var homePriceLabel: UILabel!
    
    var potentialHome: PotentialHomePurchase?
    
    let numberFormatter = NumberFormatter()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        bannerView.backgroundColor = UIColor(red:0.00, green:0.51, blue:0.33, alpha:1.0)

        guard let potentialHome = potentialHome else { return }
        
        numberFormatter.numberStyle = .decimal
        if let formattedNumber = numberFormatter.string(from: NSNumber(value: potentialHome.estimatedHomePrice)) {
            homePriceLabel.text = "$\(formattedNumber)"
        } else {
            homePriceLabel.text = "$\(potentialHome.estimatedHomePrice)"
        }
    }
}
