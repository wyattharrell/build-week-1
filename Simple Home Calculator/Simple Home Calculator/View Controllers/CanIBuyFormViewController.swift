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
    var maxDebtToIncomeRatio: Double = 0.36
    
    var potentialHome: PotentialHomePurchase?

    override func viewDidLoad() {
        super.viewDidLoad()
        calculateButton.layer.cornerRadius = 12
        calculateButton.backgroundColor = UIColor(red:0.00, green:0.51, blue:0.33, alpha:1.0)
    }
    
    @IBAction func maxDebtToIncomeRatioSegmentedControlTapped(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            maxDebtToIncomeRatio = 0.36
        case 1:
            let alert = UIAlertController(title: "Maximum Housing Expense", message: "Enter your maximum allowed housing expense percentage", preferredStyle: .alert)
            alert.addTextField { (UITextField) in
                UITextField.placeholder = "0%"
            }
            let action = UIAlertAction(title: "Dismiss", style: .default) { _ in
                guard let percentage = alert.textFields?[0].text, let percentage_Double = Double(percentage) else {
                    return
                }
                sender.setTitle("\(Int(percentage_Double))%", forSegmentAt: 1)
                self.maxDebtToIncomeRatio = percentage_Double / 100
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        default:
            print("N/A")
        }
    }
    
    
    @IBAction func calculateButtonTapped(_ sender: Any) {
        guard let income = income else { return }
        guard let maxMonthlyPaymentBasedOnIncome_M1 = maxMonthlyPaymentBasedOnIncome_M1 else { return }
        guard let monthlyDebts = monthlyDebtsTextField.text, let monthlyDebts_Int = Int(monthlyDebts) else { return }
        guard let propertyTax = propertyTaxesTextField.text, let propertyTax_Double = Double(propertyTax), let hoa = homeOwnersInsuranceTextField.text, let hoa_Double = Double(hoa), let privateMortgageInsurance = privateMortgageInsuranceTextField.text, let privateMortgageInsurance_Double = Double(privateMortgageInsurance), let hoaFees = hoaFeesTextField.text, let hoaFees_Double = Double(hoaFees), let otherFees = otherFeesTextField.text, let otherFees_Double = Double(otherFees) else { return }
        guard let availableFunds = availableFundsTextField.text, let availableFunds_Double = Double(availableFunds), let minDownPayment = minDownPaymentTextField.text, let minDownPayment_Double = Double(minDownPayment) else { return }
        guard let fixedClosingCosts = fixedClosingCostsTextField.text, let fixedClosingCosts_Double = Double(fixedClosingCosts), let variableClosingCostss = variableClosingCosts.text, let variableClosingCosts_Double = Double(variableClosingCostss) else { return }
        guard let annualInterestRate = annualInterestRateTextField.text, let annualInterestRate_Double = Double(annualInterestRate) else { return }
        
        let expenses = propertyTax_Double + hoa_Double + hoaFees_Double + privateMortgageInsurance_Double + otherFees_Double
        
        maxMonthlyPaymentBasedOnDebt_M2 = calculateMaxMonthlyPaymentBasedOnDebt_M2(income: income, debt: monthlyDebts_Int, maxDTIRatio: maxDebtToIncomeRatio)
        lowerOfM1M2 = calculateLowerOfM1M2(m1: maxMonthlyPaymentBasedOnIncome_M1, m2: maxMonthlyPaymentBasedOnDebt_M2)
        maxPIPaymentBasedOnExpenses_M3 = calculatePIPaymentBasedOnExpenses_M3(lowerOfM1orM2: lowerOfM1M2, expenses: expenses)
        maxHomePriceBasedOnFunds = calculateMaxHomePriceBasedOnFunds(availFunds: availableFunds_Double, fixedClosingCosts: fixedClosingCosts_Double, variableClosingCosts: variableClosingCosts_Double, minDownPayment: minDownPayment_Double)
        
        var term: Double = 0
        switch termOfMortgageSegmentedControl.selectedSegmentIndex {
            case 0:
                term = 15 * 12
            case 1:
                term = 30 * 12
            case 2:
                term = 40 * 12
            default:
                print("N/A")
        }
        
        let aIR = (annualInterestRate_Double / 100) / 12
        let tem = minDownPayment_Double / 100
        let temp = maxHomePriceBasedOnFunds * (1 - tem)
        maxPIPaymentBasedOnFunds_M4 = calculateMaxPIPaymentBasedOnFunds_M4(r: aIR, n: term, pv: temp)
        lowerOfM3M4 = calculateLowerOfM3M4(m3: maxPIPaymentBasedOnExpenses_M3, m4: maxPIPaymentBasedOnFunds_M4)
        loanAmountBasedOnMaxPIPayment = calculateLoanAmountBasedOnMaxPIPayment(maxHomePriceBasedOnFundss: maxHomePriceBasedOnFunds, minDownPayment: tem)
        downPaymentBasedOnAvailFunds = calculateDownPaymentBasedOnAvailFunds(availableFunds: availableFunds_Double, fixedClosingCosts: fixedClosingCosts_Double, variableClosingCosts: variableClosingCosts_Double)
        totalEstimatedClosingCosts = calculateTotalEstimatedClosingCosts(variableClosingCosts: variableClosingCosts_Double, loanAmountBasedOnMaxPIPayment: loanAmountBasedOnMaxPIPayment, fixedClosingCosts: fixedClosingCosts_Double, downPaymentBasedOnAvailFunds: downPaymentBasedOnAvailFunds)
        maxHomePrice = calculateMaxHomePrice(a: loanAmountBasedOnMaxPIPayment, b: downPaymentBasedOnAvailFunds)

        potentialHome = PotentialHomePurchase(estimatedHomePrice: Int(maxHomePrice), piPayment: Int(lowerOfM3M4), propertyTax: Int(propertyTax_Double), insurance: Int(hoa_Double), pmi: Int(privateMortgageInsurance_Double), hoa: Int(hoaFees_Double), otherExpenses: Int(otherFees_Double), loanAmount: Int(loanAmountBasedOnMaxPIPayment), downPayment: Int(downPaymentBasedOnAvailFunds), estClosingCosts: Int(totalEstimatedClosingCosts))
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCanIBuyResults" {
            guard let CanIBuyResultsVC = segue.destination as? CanIBuyResultsViewController else { return }
            CanIBuyResultsVC.potentialHome = potentialHome
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
        let b = (variableClosingCosts / 100) + (minDownPayment / 100)
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
    
    func calculateDownPaymentBasedOnAvailFunds(availableFunds: Double, fixedClosingCosts: Double, variableClosingCosts: Double) -> Double {
        let varClosing = (variableClosingCosts / 100)
        var result = availableFunds - fixedClosingCosts
        
        result = result - (varClosing * loanAmountBasedOnMaxPIPayment)
        result = result / (1+varClosing)
        return result
    }

    func calculateTotalEstimatedClosingCosts(variableClosingCosts: Double, loanAmountBasedOnMaxPIPayment: Double, fixedClosingCosts: Double, downPaymentBasedOnAvailFunds: Double) -> Double {
        return (variableClosingCosts / 100 ) * (loanAmountBasedOnMaxPIPayment + downPaymentBasedOnAvailFunds) + fixedClosingCosts
    }
    
    func calculateMaxHomePrice(a: Double, b: Double) -> Double {
        return a + b
    }
}

extension CanIBuyViewController: UITextFieldDelegate {
    
}
