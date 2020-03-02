//
//  MortgageCalculatorViewController.swift
//  Simple Home Calculator
//
//  Created by Lambda_School_Loaner_259 on 3/1/20.
//  Christopher DeVito
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit

class MortgageCalculatorViewController: UIViewController {
    
    // MARK: - Properties
    var mortgageLoanController: MortgageLoanController?
    lazy private var mortgagePickerData: [[String]] = {
        let loanType: [String] = [.mortgage, .vaLoan, .refinance]
        let data: [[String]] = [["Type"], loanType]
        return data
    }()
    
    lazy private var mortgageLengthData: [[String]] = {
        let loanDuration: [String] = ["15 Years", "30 Years", "5/1 ARM"]
        let data: [[String]] = [["Mortgage Duration"], loanDuration]
        return data
    }()
    
    
    // MARK: - IBOutlets
    @IBOutlet var calculateMortgageButton: UIButton!
    @IBOutlet var loanAmountTextField: UITextField!
    @IBOutlet var interestRateTextField: UITextField!
    @IBOutlet var downPaymentTextField: UITextField!
    @IBOutlet var mortgagePickerView: UIPickerView!
    
    
    // MARK: - IBActions
    
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        mortgagePickerView.delegate = self
        mortgagePickerView.dataSource = self
        

        calculateMortgageButton.layer.cornerRadius = 12
        calculateMortgageButton.backgroundColor = UIColor(red:0.00, green:0.51, blue:0.33, alpha:1.0)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MortgageCalculatorViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return mortgagePickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return mortgagePickerData[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return mortgagePickerData[component][row]
    }
    
}
