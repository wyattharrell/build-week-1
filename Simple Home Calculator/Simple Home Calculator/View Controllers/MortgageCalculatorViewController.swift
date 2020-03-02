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
    var mortgageLoanController = MortgageLoanController.mortgageLoanController
    lazy private var mortgageTypeData: [[String]] = {
        let loanType: [String] = [.mortgage, .vaLoan, .refinance]
        let data: [[String]] = [["Type"], loanType]
        return data
    }()
    
    lazy private var mortgageLengthData: [[String]] = {
        let loanLength: [String] = ["15 Years", "30 Years", "5/1 ARM"]
        let data: [[String]] = [["Length"], loanLength]
        return data
    }()
    
    
    // MARK: - IBOutlets
    @IBOutlet var calculateMortgageButton: UIButton!
    @IBOutlet var loanAmountTextField: UITextField!
    @IBOutlet var interestRateTextField: UITextField!
    @IBOutlet var downPaymentTextField: UITextField!
    @IBOutlet var mortgageLengthPickerView: UIPickerView!
    @IBOutlet var mortgageTypePickerView: UIPickerView!
    
    
    // MARK: - IBActions
    
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        mortgageLengthPickerView.delegate = self
        mortgageLengthPickerView.dataSource = self
        mortgageTypePickerView.delegate = self
        mortgageTypePickerView.dataSource = self
        guard let mortgageLoan = mortgageLoanController.mortgageLoan else { return }
        let mortgageType = mortgageLoan.mortgageType
        if mortgageType == .mortgage {
            mortgageTypePickerView.selectRow(0, inComponent: 1, animated: true)
        } else if mortgageType == .vaLoan {
            mortgageTypePickerView.selectRow(1, inComponent: 1, animated: true)
        } else {
            mortgageTypePickerView.selectRow(2, inComponent: 1, animated: true)
        }

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
        if pickerView.tag == 0 {
            return mortgageTypeData.count
        } else {
            return mortgageLengthData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return mortgageTypeData[component].count
        } else {
            return mortgageLengthData[component].count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return mortgageTypeData[component][row]
        } else {
            return mortgageLengthData[component][row]
        }
    }
    
}
