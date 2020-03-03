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
    
    var maxHousingExpensePercent: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculateButton.layer.cornerRadius = 12
        calculateButton.backgroundColor = UIColor(red:0.00, green:0.51, blue:0.33, alpha:1.0)
        
        circleImageView.tintColor = UIColor(red:0.00, green:0.51, blue:0.33, alpha:1.0)
    }
    
    @IBAction func expensePercentSegmentedControllTapped(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            maxHousingExpensePercent = 0.28
        case 1:
            #warning("MUST CALL A UIALERT")
        default:
            print("N/A")
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCanIBuyForm" {
            guard let CanIBuyFormVC = segue.destination as? CanIBuyFormViewController else { return }
            
            guard let income = annualIncomeTextField.text, !income.isEmpty else { return }
            
            switch expensePercentSegmentedControl.selectedSegmentIndex {
                case 0:
                    let result = calculateMaxMonthlyPaymentBasedOnIncome_M1(income: Int(income)!, maxHousingExpense: 0.28)
                    CanIBuyFormVC.maxMonthlyPaymentBasedOnIncome_M1 = result
                    CanIBuyFormVC.income = Int(income)
                case 1:
                    let result = calculateMaxMonthlyPaymentBasedOnIncome_M1(income: Int(income)!, maxHousingExpense: maxHousingExpensePercent)
                    CanIBuyFormVC.maxMonthlyPaymentBasedOnIncome_M1 = result
                    CanIBuyFormVC.income = Int(income)
                default:
                    print("N/A")
            }
        }
    }

    func calculateMaxMonthlyPaymentBasedOnIncome_M1(income: Int, maxHousingExpense: Double) -> Double {
        return Double(income) * maxHousingExpense / 12
    }
    
}

#warning("ADD ERROR CHECKING FOR BLACK TEXTFIELD")
