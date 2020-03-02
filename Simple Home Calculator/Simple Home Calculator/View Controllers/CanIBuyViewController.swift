//
//  CanIBuyViewController.swift
//  Simple Home Calculator
//
//  Created by Wyatt Harrell on 2/29/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit

class CanIBuyViewController: UIViewController {

    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var circleImageView: UIImageView!
    @IBOutlet weak var annualIncomeTextField: UITextField!
    @IBOutlet weak var expensePercentSegmentedControl: UISegmentedControl!
    
    var maxHousingExpensePercent: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculateButton.layer.cornerRadius = 12
        calculateButton.backgroundColor = UIColor(red:0.00, green:0.51, blue:0.33, alpha:1.0)
        
        circleImageView.tintColor = UIColor(red:0.00, green:0.51, blue:0.33, alpha:1.0)
    }
    
    @IBAction func expensePercentSegmentedControllTapped(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            maxHousingExpensePercent = 28
        case 1:
            #warning("MUST CALL A UIALERT")
        default:
            print("N/A")
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCanIBuyForm" {
            guard let showCanIBuyFormVC = segue.destination as? CanIBuyFormViewController else { return }
            
            guard let income = annualIncomeTextField.text, !income.isEmpty else { return }
            
            showCanIBuyFormVC.annualIncome = Int(income)
            
            switch expensePercentSegmentedControl.selectedSegmentIndex {
                case 0:
                    showCanIBuyFormVC.maxHousingExpensePercent = 28
                case 1:
                    print("none")
                default:
                    print("N/A")
            }
        }
    }
}
