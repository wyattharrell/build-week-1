//
//  CanIBuyFormViewController.swift
//  Simple Home Calculator
//
//  Created by Wyatt Harrell on 3/2/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit

class CanIBuyFormViewController: UIViewController {

    @IBOutlet weak var calculateButton: UIButton!
    
    @IBOutlet weak var monthlyDebtsTextField: UITextField!
    @IBOutlet weak var maxDebtToIncomeRatioSegmentedControl: UISegmentedControl!
    @IBOutlet weak var propertyTaxesTextField: UITextField!
    @IBOutlet weak var homeOwnersInsuranceTextField: UITextField!
    @IBOutlet weak var privateMortgageInsuranceTextField: UITextField!
    @IBOutlet weak var hoaFeesTextField: UITextField!
    @IBOutlet weak var otherFeesTextField: UITextField!
    @IBOutlet weak var availableFundsTextField: UITextField!
    @IBOutlet weak var fixedClosingCostsTextField: UITextField!
    @IBOutlet weak var variableClosingCosts: UITextField!
    @IBOutlet weak var minDownPaymentTextField: UITextField!
    @IBOutlet weak var termOfMortgageSegmentedControl: UISegmentedControl!
    @IBOutlet weak var annualInterestRateTextField: UITextField!
    
    var income: Int?
    var maxMonthlyPaymentBasedOnIncome_M1: Double?
    var maxMonthlyPaymentBasedOnDebt_M2: Double = 0
    var maxPIPaymentBasedOnExpenses_M3: Double = 0
    var maxPIPaymentBasedOnFunds_M4: Double = 0

    var lowerOfM1M2: Double = 0
    var lowerOfM3M4: Double = 0
    
    var maxHomePriceBasedOnFunds: Double = 0
    
    
    
    
    
    var maxMonthlyPayment: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculateButton.layer.cornerRadius = 12
        calculateButton.backgroundColor = UIColor(red:0.00, green:0.51, blue:0.33, alpha:1.0)
    }
    
    @IBAction func calculateButtonTapped(_ sender: Any) {
        guard let income = income else { return }
        
        
        
        // maxMonthlyPaymentBasedOnDebt_M2 = calculateMaxMonthlyPaymentBasedOnDebt_M2(income: income, debt: 400, maxDTIRatio: 0.36)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCanIBuyResults" {
            //guard let CanIBuyResultsVC = segue.destination as? CanIBuyResultsViewController else { return }
           
        }
    }

    // MARK: - Calculations
    
    func calculateMaxMonthlyPaymentBasedOnDebt_M2(income: Int, debt: Int, maxDTIRatio: Double) -> Double {
        return maxDTIRatio * Double((income / 12)) - Double(debt)
    }
    
    func calculateLowerOfM1M2(m1: Double, m2: Double) -> Double {
        return min(m1, m2)
    }
    
    func calculatePIPaymentBasedOnExpenses_M3(lowerOfM1orM2: Double, expenses: Double) -> Double {
        return lowerOfM1orM2 - expenses
    }
    
    func calculateMaxHomePriceBasedOnFunds(availFunds: Double, fixedClosingCosts: Double, variableClosingCosts: Double, minDownPayment: Double) -> Double {
        let a = availFunds - fixedClosingCosts
        let b = variableClosingCosts + minDownPayment
        return a / b
    }
    
    func calculateLowerOfM3M4(m3: Double, m4: Double) -> Double {
        return min(m3,m4)
    }
    
    func calculatemMaxPIPaymentBasedOnFunds_M4(r: Double, n: Double, pv: Double) -> Double {
        let temp = (1 + r)
        let negativeN = 0 - n
        return pv * (r / (1 - pow(temp, negativeN)))
    }
    
    
}


extension CanIBuyViewController: UITextFieldDelegate {
    #warning("IMPLEMENT")
}
