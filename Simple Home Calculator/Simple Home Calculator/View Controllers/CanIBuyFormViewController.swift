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
    
    var annualIncome: Int?
    var maxHousingExpensePercent: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculateButton.layer.cornerRadius = 12
        calculateButton.backgroundColor = UIColor(red:0.00, green:0.51, blue:0.33, alpha:1.0)
    }
    
    
    @IBAction func calculateButtonTapped(_ sender: Any) {
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }

}


extension CanIBuyViewController: UITextFieldDelegate {
    
}
