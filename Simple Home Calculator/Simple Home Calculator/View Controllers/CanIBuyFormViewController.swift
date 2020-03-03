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
    var loanAmountBasedOnMaxPIPayment: Double = 0
    var downPaymentBasedOnAvailFunds: Double = 0
    var totalEstimatedClosingCosts: Double = 0
    var maxHomePrice: Double = 0
    var maxHomePriceBasedOnFunds: Double = 0

    var maxDebtToIncomeRatio: Double = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculateButton.layer.cornerRadius = 12
        calculateButton.backgroundColor = UIColor(red:0.00, green:0.51, blue:0.33, alpha:1.0)
    }
    
    @IBAction func calculateButtonTapped(_ sender: Any) {
        guard let income = income else { return }
        guard let maxMonthlyPaymentBasedOnIncome_M1 = maxMonthlyPaymentBasedOnIncome_M1 else { return }
        guard let monthlyDebts = monthlyDebtsTextField.text, let monthlyDebts_Int = Int(monthlyDebts) else { return }
        guard let propertyTax = propertyTaxesTextField.text, let propertyTax_Double = Double(propertyTax), let hoa = homeOwnersInsuranceTextField.text, let hoa_Double = Double(hoa), let privateMortgageInsurance = privateMortgageInsuranceTextField.text, let privateMortgageInsurance_Double = Double(privateMortgageInsurance), let hoaFees = hoaFeesTextField.text, let hoaFees_Double = Double(hoaFees), let otherFees = otherFeesTextField.text, let otherFees_Double = Double(otherFees) else { return }
        
        
        switch maxDebtToIncomeRatioSegmentedControl.selectedSegmentIndex {
            case 0:
                maxDebtToIncomeRatio = 0.36
            case 1:
                #warning("MUST CALL A UIALERT")
            default:
                print("N/A")
        }
        
        let expenses = propertyTax_Double + hoa_Double + hoaFees_Double + privateMortgageInsurance_Double + otherFees_Double
        
        maxMonthlyPaymentBasedOnDebt_M2 = calculateMaxMonthlyPaymentBasedOnDebt_M2(income: income, debt: monthlyDebts_Int, maxDTIRatio: maxDebtToIncomeRatio)
        lowerOfM1M2 = calculateLowerOfM1M2(m1: maxMonthlyPaymentBasedOnIncome_M1, m2: maxMonthlyPaymentBasedOnDebt_M2)
        maxPIPaymentBasedOnExpenses_M3 = calculatePIPaymentBasedOnExpenses_M3(lowerOfM1orM2: lowerOfM1M2, expenses: expenses)
        
        guard let availableFunds = availableFundsTextField.text, let availableFunds_Double = Double(availableFunds), let minDownPayment = minDownPaymentTextField.text, let minDownPayment_Double = Double(minDownPayment) else { return }
        
        guard let fixedClosingCosts = fixedClosingCostsTextField.text, let fixedClosingCosts_Double = Double(fixedClosingCosts), let variableClosingCostss = variableClosingCosts.text, let variableClosingCosts_Double = Double(variableClosingCostss) else { return }
        
        
        maxHomePriceBasedOnFunds = calculateMaxHomePriceBasedOnFunds(availFunds: availableFunds_Double, fixedClosingCosts: fixedClosingCosts_Double, variableClosingCosts: variableClosingCosts_Double, minDownPayment: minDownPayment_Double)
        
        maxPIPaymentBasedOnFunds_M4 = calculateMaxPIPaymentBasedOnFunds_M4(r: <#T##Double#>, n: <#T##Double#>, pv: <#T##Double#>)
        
        lowerOfM3M4 = calculateLowerOfM3M4(m3: maxPIPaymentBasedOnExpenses_M3, m4: maxPIPaymentBasedOnFunds_M4)
        
        
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
    
    func calculateMaxPIPaymentBasedOnFunds_M4(r: Double, n: Double, pv: Double) -> Double {
        let temp = (1 + r)
        let negativeN = 0 - n
        return pv * (r / (1 - pow(temp, negativeN)))
    }
    
    func calculateLoanAmountBasedOnMaxPIPayment(maxHomePriceBasedOnFundss: Double, minDownPayment: Double) -> Double {
        return maxHomePriceBasedOnFundss * (1-minDownPayment) //pass 0.2 not 20
    }
    
//    func calculateDownPaymentBasedOnAvailFunds() -> Double {
//
//    }
//
//    func calculateTotalEstimatedClosingCosts() -> Double {
//
//    }
    
    func calculateMaxHomePrice(a: Double, b: Double) -> Double {
        return a + b //totalEstimatedClosingCosts + downPaymentBasedOnAvailFunds
    }
    
    
}


extension CanIBuyViewController: UITextFieldDelegate {
    #warning("IMPLEMENT")
}
