//
//  CostOfLivingResultsViewController.swift
//  Simple Home Calculator
//
//  Created by Wyatt Harrell on 3/4/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit

class CostOfLivingResultsViewController: UIViewController {

    
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var increaseOrDecreaseLabel: UILabel!
    
    var currentState: State?
    var futureState: State?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }

    func updateViews() {
        guard let futureState = futureState, let currentState = currentState else { return }
        
        stateLabel.text = "\(currentState.State) vs. \(futureState.State)"
        if currentState.costRank < futureState.costRank {
            increaseOrDecreaseLabel.text = "Cost Of Living Increase"
            arrowImage.image = UIImage(systemName: "arrow.up")
        } else {
            increaseOrDecreaseLabel.text = "Cost Of Living Decrease"
            arrowImage.image = UIImage(systemName: "arrow.down")
        }

    }

}
