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
    
    @IBOutlet weak var currentCostIndexLabel: UILabel!
    @IBOutlet weak var currentGroceryLabel: UILabel!
    @IBOutlet weak var currentHousingLabel: UILabel!
    @IBOutlet weak var currentUtilitesLabel: UILabel!
    @IBOutlet weak var currentTransportationLabel: UILabel!
    @IBOutlet weak var currentMiscLabel: UILabel!

    @IBOutlet weak var futureCostLabel: UILabel!
    @IBOutlet weak var futureGroceryLabel: UILabel!
    @IBOutlet weak var futureHousingLabel: UILabel!
    @IBOutlet weak var futureUtilitiesLabel: UILabel!
    @IBOutlet weak var futureTransportationLabel: UILabel!
    @IBOutlet weak var futureMiscLabel: UILabel!
    
    @IBOutlet weak var currentRankLabel: UILabel!
    @IBOutlet weak var futureRankLabel: UILabel!
    
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
        } else if currentState.costRank > futureState.costRank {
            increaseOrDecreaseLabel.text = "Cost Of Living Decrease"
            arrowImage.image = UIImage(systemName: "arrow.down")
        } else {
            arrowImage.image = UIImage(systemName: "arrow.right.arrow.left")
            increaseOrDecreaseLabel.text = "Equal Cost Of Living"
        }
        
        if let currentCost = Double(currentState.costIndex), let currentGrocery = Double(currentState.groceryCost), let currentHousing = Double(currentState.housingCost), let currentUtilities = Double(currentState.utilitiesCost), let currentTransportation = Double(currentState.transportationCost), let currentMisc = Double(currentState.miscCost) {
            currentCostIndexLabel.text = "\(currentCost)"
            currentGroceryLabel.text = "\(currentGrocery)"
            currentHousingLabel.text = "\(currentHousing)"
            currentUtilitesLabel.text = "\(currentUtilities)"
            currentTransportationLabel.text = "\(currentTransportation)"
            currentMiscLabel.text = "\(currentMisc)"
        }
        
        if let futureCost = Double(futureState.costIndex), let futureGrocery = Double(futureState.groceryCost), let futureHousing = Double(futureState.housingCost), let futureUtilities = Double(futureState.utilitiesCost), let futureTransportation = Double(futureState.transportationCost), let futureMisc = Double(futureState.miscCost) {
            futureCostLabel.text = "\(futureCost)"
            futureGroceryLabel.text = "\(futureGrocery)"
            futureHousingLabel.text = "\(futureHousing)"
            futureUtilitiesLabel.text = "\(futureUtilities)"
            futureTransportationLabel.text = "\(futureTransportation)"
            futureMiscLabel.text = "\(futureMisc)"
        }
        
        currentRankLabel.text = "\(currentState.costRank)"
        futureRankLabel.text = "\(futureState.costRank)"
    }

}
