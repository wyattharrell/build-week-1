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
    
    let potentialHomePurchaseController = PotentialHomePurchaseController()
    var canProceed: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        calculateButton.layer.cornerRadius = 12
        calculateButton.backgroundColor = UIColor(red:0.00, green:0.51, blue:0.33, alpha:1.0)
        addAccessoryView()
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
        
        guard let monthlyDebts = monthlyDebtsTextField.text, !monthlyDebts.isEmpty, let monthlyDebts_Int = Int(monthlyDebts) else { return }
        guard let propertyTax = propertyTaxesTextField.text, !propertyTax.isEmpty, let propertyTax_Double = Double(propertyTax) else { return }
        guard let hoa = homeOwnersInsuranceTextField.text, !hoa.isEmpty, let hoa_Double = Double(hoa) else { return }
        guard let privateMortgageInsurance = privateMortgageInsuranceTextField.text, !privateMortgageInsurance.isEmpty, let privateMortgageInsurance_Double = Double(privateMortgageInsurance) else { return }
        guard let hoaFees = hoaFeesTextField.text, !hoaFees.isEmpty, let hoaFees_Double = Double(hoaFees) else { return }
        guard let otherFees = otherFeesTextField.text, !otherFees.isEmpty, let otherFees_Double = Double(otherFees) else { return }
        guard let availableFunds = availableFundsTextField.text, !availableFunds.isEmpty, let availableFunds_Double = Double(availableFunds) else { return }
        guard let minDownPayment = minDownPaymentTextField.text, !minDownPayment.isEmpty, let minDownPayment_Double = Double(minDownPayment) else { return }
        guard let fixedClosingCosts = fixedClosingCostsTextField.text, !fixedClosingCosts.isEmpty, let fixedClosingCosts_Double = Double(fixedClosingCosts) else { return }
        guard let variableClosingCostss = variableClosingCosts.text, !variableClosingCostss.isEmpty, let variableClosingCosts_Double = Double(variableClosingCostss) else { return }
        guard let annualInterestRate = annualInterestRateTextField.text, !annualInterestRate.isEmpty, let annualInterestRate_Double = Double(annualInterestRate) else { return }
                
        canProceed = true
        
        var term: Double = 0
        let expenses = propertyTax_Double + hoa_Double + hoaFees_Double + privateMortgageInsurance_Double + otherFees_Double
        let aIR = (annualInterestRate_Double / 100) / 12
        let minDownPayment_Percent = minDownPayment_Double / 100
        
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
        
        maxMonthlyPaymentBasedOnDebt_M2 = calculateMaxMonthlyPaymentBasedOnDebt_M2(income: income, debt: monthlyDebts_Int, maxDTIRatio: maxDebtToIncomeRatio)
        lowerOfM1M2 = calculateLowerOfM1M2(m1: maxMonthlyPaymentBasedOnIncome_M1, m2: maxMonthlyPaymentBasedOnDebt_M2)
        maxPIPaymentBasedOnExpenses_M3 = calculatePIPaymentBasedOnExpenses_M3(lowerOfM1orM2: lowerOfM1M2, expenses: expenses)
        maxHomePriceBasedOnFunds = calculateMaxHomePriceBasedOnFunds(availFunds: availableFunds_Double, fixedClosingCosts: fixedClosingCosts_Double, variableClosingCosts: variableClosingCosts_Double, minDownPayment: minDownPayment_Double)
        maxPIPaymentBasedOnFunds_M4 = calculateMaxPIPaymentBasedOnFunds_M4(r: aIR, n: term, maxHomePriceBasedOnFunds: maxHomePriceBasedOnFunds, minDownPayment_Percent: minDownPayment_Percent)
        lowerOfM3M4 = calculateLowerOfM3M4(m3: maxPIPaymentBasedOnExpenses_M3, m4: maxPIPaymentBasedOnFunds_M4)
        loanAmountBasedOnMaxPIPayment = calculateLoanAmountBasedOnMaxPIPayment(maxHomePriceBasedOnFunds: maxHomePriceBasedOnFunds, minDownPayment: minDownPayment_Percent)
        downPaymentBasedOnAvailFunds = calculateDownPaymentBasedOnAvailFunds(availableFunds: availableFunds_Double, fixedClosingCosts: fixedClosingCosts_Double, variableClosingCosts: variableClosingCosts_Double)
        totalEstimatedClosingCosts = calculateTotalEstimatedClosingCosts(variableClosingCosts: variableClosingCosts_Double, loanAmountBasedOnMaxPIPayment: loanAmountBasedOnMaxPIPayment, fixedClosingCosts: fixedClosingCosts_Double, downPaymentBasedOnAvailFunds: downPaymentBasedOnAvailFunds)
        maxHomePrice = calculateMaxHomePrice(a: loanAmountBasedOnMaxPIPayment, b: downPaymentBasedOnAvailFunds)

        potentialHomePurchaseController.create(estimatedHomePrice: Int(maxHomePrice), piPayment: Int(lowerOfM3M4), propertyTax: Int(propertyTax_Double), insurance: Int(hoa_Double), pmi: Int(privateMortgageInsurance_Double), hoa: Int(hoaFees_Double), otherExpenses: Int(otherFees_Double), loanAmount: Int(loanAmountBasedOnMaxPIPayment), downPayment: Int(downPaymentBasedOnAvailFunds), estClosingCosts: Int(totalEstimatedClosingCosts))
    }
    
    // MARK: - Navigation
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if !canProceed {
            let alert = UIAlertController(title: "All text fields are required", message: "Please complete all text fields", preferredStyle: .alert)
            let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            return false
        }
        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCanIBuyResults" {
            guard let CanIBuyResultsVC = segue.destination as? CanIBuyResultsViewController else { return }
            CanIBuyResultsVC.potentialHome = potentialHomePurchaseController.potentialHomes[potentialHomePurchaseController.potentialHomes.count-1]
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
    
    func calculateMaxPIPaymentBasedOnFunds_M4(r: Double, n: Double, maxHomePriceBasedOnFunds: Double, minDownPayment_Percent: Double) -> Double {
        let temp = maxHomePriceBasedOnFunds * (1 - minDownPayment_Percent)
        let temp2 = (1 + r)
        let negativeN = 0 - n
        return temp * (r / (1 - pow(temp2, negativeN)))
    }
    
    func calculateLoanAmountBasedOnMaxPIPayment(maxHomePriceBasedOnFunds: Double, minDownPayment: Double) -> Double {
        return maxHomePriceBasedOnFunds * (1-minDownPayment) //pass 0.2 not 20
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

// MARK: - TextField Toolbar

extension CanIBuyFormViewController {
    func addAccessoryView() -> Void {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44))
        let nextButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(self.nextButtonTapped(button:)))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonTapped(button:)))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.items = [nextButton, flexSpace, doneButton]
        toolBar.tintColor = UIColor(red:0.00, green:0.51, blue:0.33, alpha:1.0)
        monthlyDebtsTextField.inputAccessoryView = toolBar
        propertyTaxesTextField.inputAccessoryView = toolBar
        homeOwnersInsuranceTextField.inputAccessoryView = toolBar
        privateMortgageInsuranceTextField.inputAccessoryView = toolBar
        hoaFeesTextField.inputAccessoryView = toolBar
        otherFeesTextField.inputAccessoryView = toolBar
        availableFundsTextField.inputAccessoryView = toolBar
        fixedClosingCostsTextField.inputAccessoryView = toolBar
        variableClosingCosts.inputAccessoryView = toolBar
        minDownPaymentTextField.inputAccessoryView = toolBar
        annualInterestRateTextField.inputAccessoryView = toolBar
    }
    
    @objc func nextButtonTapped(button:UIBarButtonItem) -> Void {
        if monthlyDebtsTextField.isFirstResponder {
            propertyTaxesTextField.becomeFirstResponder()
        } else if propertyTaxesTextField.isFirstResponder {
            homeOwnersInsuranceTextField.becomeFirstResponder()
        } else if homeOwnersInsuranceTextField.isFirstResponder {
            privateMortgageInsuranceTextField.becomeFirstResponder()
        } else if privateMortgageInsuranceTextField.isFirstResponder {
            hoaFeesTextField.becomeFirstResponder()
        } else if hoaFeesTextField.isFirstResponder {
            otherFeesTextField.becomeFirstResponder()
        } else if otherFeesTextField.isFirstResponder {
            availableFundsTextField.becomeFirstResponder()
        } else if availableFundsTextField.isFirstResponder {
            fixedClosingCostsTextField.becomeFirstResponder()
        } else if fixedClosingCostsTextField.isFirstResponder {
            variableClosingCosts.becomeFirstResponder()
        } else if variableClosingCosts.isFirstResponder {
            minDownPaymentTextField.becomeFirstResponder()
        } else if minDownPaymentTextField.isFirstResponder {
            annualInterestRateTextField.becomeFirstResponder()
        } else if annualInterestRateTextField.isFirstResponder {
            annualInterestRateTextField.resignFirstResponder()
        }
    }
    
    @objc func doneButtonTapped(button:UIBarButtonItem) -> Void {
        self.view.endEditing(true)
    }
}
