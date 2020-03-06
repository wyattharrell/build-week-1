//
//  MortgagePage1ViewController.swift
//  Simple Home Calculator
//
//  Created by Lambda_School_Loaner_259 on 3/1/20.
//  Christopher DeVito
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit

class MortgagePage1ViewController: UIViewController {
    
    // MARK: - Properties
    private let mortgageTypes: [String] = ["Mortgage", "5/1 ARM", "Refinance"]
    var mortgageLoanController = MortgageLoanController.mortgageLoanController
    
    
    // MARK: - IBOutlets
    @IBOutlet var titleImage: UIImageView!
    @IBOutlet var traditionalmortgageButton: UIButton!
    @IBOutlet var armButton: UIButton!
    

    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mortgageLoanController.loadFromPersistentStore()

        traditionalmortgageButton.layer.cornerRadius = 12
        traditionalmortgageButton.backgroundColor = UIColor(red:0.00, green:0.51, blue:0.33, alpha:1.0)
        armButton.layer.cornerRadius = 12
        armButton.backgroundColor = UIColor(red:0.00, green:0.51, blue:0.33, alpha:1.0)
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TraditionalMortgageSegue" {
            let mortgageType = "Mortgage"
            mortgageLoanController.createMortgageLoan(mortgageType: mortgageType)
            let mortgageP2VC = segue.destination as! MortgageCalculatorViewController
            mortgageP2VC.mortgageLoanController = mortgageLoanController
        } else if segue.identifier == "ARMSegue" {
            let mortgageType = "ARM"
            mortgageLoanController.createMortgageLoan(mortgageType: mortgageType)
            let armP2VC = segue.destination as! MortgageARMCalculatorViewController
            armP2VC.mortgageLoanController = mortgageLoanController
        }
    }
    
    @IBAction func unwindToHome(sender: UIStoryboardSegue) {
        mortgageLoanController.mortgageLoan = nil
    }

}
