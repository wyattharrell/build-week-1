//
//  MortgageARMCalculatorViewController.swift
//  Simple Home Calculator
//
//  Created by Lambda_School_Loaner_259 on 3/5/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit

class MortgageARMCalculatorViewController: UIViewController {
    
    // MARK: - Properties
    var mortgageLoanController = MortgageLoanController.mortgageLoanController
    
    lazy private var mortgageLengthData: [[String]] = {
        let loanLength: [String] = ["15 Years", "20 Years", "30 Years", "40 Years"]
        let data: [[String]] = [["Years: "], loanLength]
        return data
    }()
    
    var mortgageLength: Int? = 15
    var initialLength: Int? = 5
    
    private var mortgageInitialLengthData: [[String]] = {
        var loanLength: [String] = []
        for i in 1...10 {
            loanLength.append(String(i))
        }
        let data: [[String]] = [["Years: "], loanLength]
        return data
    }()
    
    // MARK: - IBOutlets
    @IBOutlet var errorLabel: UILabel!
    
    @IBOutlet var loanAmountTextField: UITextField!
    @IBOutlet var downPaymentTextField: UITextField!
    @IBOutlet var monthlyHOATextField: UITextField!
    
    @IBOutlet var initialInterestRateTextField: UITextField!
    @IBOutlet var maxInterestRateTextField: UITextField!
    @IBOutlet var estimatedRateChangeTextField: UITextField!
    
    @IBOutlet var homeInsuranceTextField: UITextField!
    @IBOutlet var propertyTaxTextField: UITextField!
    
    @IBOutlet var initialLengthPickerView: UIPickerView!
    @IBOutlet var totalLengthPickerView: UIPickerView!
    
    @IBOutlet var calculateARMButton: UIButton!
    
    

    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addAccessoryView()
        
        initialLengthPickerView.delegate = self
        initialLengthPickerView.dataSource = self
        totalLengthPickerView.delegate = self
        totalLengthPickerView.dataSource = self
        
        guard let mortgageLoan = mortgageLoanController.mortgageLoan else { return }
        title = "\(mortgageLoan.mortgageType)"

        calculateARMButton.layer.cornerRadius = 12
        calculateARMButton.backgroundColor = UIColor(red:0.00, green:0.51, blue:0.33, alpha:1.0)
        
        initialLengthPickerView.selectRow(4, inComponent: 1, animated: true)
        totalLengthPickerView.selectRow(0, inComponent: 1, animated: true)

        // Do any additional setup after loading the view.
    }
    
    func getAllInputs() {
        
        let loanAmount = getLoanAmount()
        let downPayment = getDownPayment()
        let monthlyHOASTring = monthlyHOATextField.text ?? "0.0"
        let monthlyHOA = Double(monthlyHOASTring) ?? 0.0
        
        let initialInterestRate = getInitialInterestRate()
        let maxInterestRate = getMaxInterestRate()
        let estRateChange = getEstRateChange()
        
        let mortgageLength = getMortgageLength()
        let initialLength = getInitialLength()
        
        let homeInsuranceString = homeInsuranceTextField.text ?? "0.0"
        let homeInsurance = Double(homeInsuranceString) ?? 0.0
        let propertyTaxString = propertyTaxTextField.text ?? "0.0"
        let propertyTax = Double(propertyTaxString) ?? 0.0

        
        mortgageLoanController.updateARMLoan(mortgageLoan: mortgageLoanController.mortgageLoan!, amount: loanAmount, downPayment: downPayment, initialInterestRate: initialInterestRate, maxInterestRate: maxInterestRate, estRateChange: estRateChange, mortgageLength: mortgageLength, initialLength: initialLength, monthlyHOA: monthlyHOA, homeInsurance: homeInsurance, propertyTax: propertyTax)
        
    }
    
    func getLoanAmount() -> Double {
        guard let loanAmountString = loanAmountTextField.text,
            !loanAmountString.isEmpty else { return 0.0 }
        guard let loanAmount = Double(loanAmountString) else { return 0.0 }
        return loanAmount
    }
    
    func getInitialInterestRate() -> Double {
        guard let interestRateString = initialInterestRateTextField.text,
            !interestRateString.isEmpty else { return 0.0 }
        guard let interestRate = Double(interestRateString) else { return 0.0 }
        return interestRate
    }
    
    func getMaxInterestRate() -> Double {
        guard let interestRateString = maxInterestRateTextField.text, !interestRateString.isEmpty else { return 0.0 }
        guard let interestRate = Double(interestRateString) else { return 0.0 }
        return interestRate
    }
    
    func getEstRateChange() -> Double {
        guard let interestRateString = estimatedRateChangeTextField.text, !interestRateString.isEmpty else { return 0.0 }
        guard let interestRate = Double(interestRateString) else { return 0.0 }
        return interestRate
    }
    
    func getDownPayment() -> Double {
        guard let downPaymentString = downPaymentTextField.text,
            !downPaymentString.isEmpty else { return 0.0 }
        guard let downPayment = Double(downPaymentString) else { return 0.0 }
        return downPayment
    }
    
    func getMortgageLength() -> Int {
        guard let length = mortgageLength else { return 0 }
        return length
    }
    
    func getInitialLength() -> Int {
        guard let length = initialLength else { return 0 }
        return length
    }


     //MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         getAllInputs()
    }


}

extension MortgageARMCalculatorViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView.tag == 1 {
            return mortgageInitialLengthData.count
        } else {
            return mortgageLengthData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return mortgageInitialLengthData[component].count
        } else {
            return mortgageLengthData[component].count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return mortgageInitialLengthData[component][row]
        } else {
            return mortgageLengthData[component][row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            let initialLengthString = mortgageInitialLengthData[component][row]
            guard let initialLength = Int(initialLengthString) else { return }
            self.initialLength = initialLength
        } else {
            let mortgageLengthString = mortgageLengthData[component][row]
            if  mortgageLengthString == mortgageLengthData[1][0] {
                mortgageLength = .fifteen
            } else if mortgageLengthString == mortgageLengthData[1][1] {
                mortgageLength = .twenty
            } else if mortgageLengthString == mortgageLengthData[1][2] {
                mortgageLength = .thirty
            } else {
                mortgageLength = .forty
            }
        }
    }
    
}


extension MortgageARMCalculatorViewController {
    func addAccessoryView() -> Void {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44))
        let nextButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(self.nextButtonTapped(button:)))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonTapped(button:)))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.items = [nextButton, flexSpace, doneButton]
        toolBar.tintColor = UIColor(red:0.00, green:0.51, blue:0.33, alpha:1.0)
        loanAmountTextField.inputAccessoryView = toolBar
        downPaymentTextField.inputAccessoryView = toolBar
        monthlyHOATextField.inputAccessoryView = toolBar
        
        initialInterestRateTextField.inputAccessoryView = toolBar
        maxInterestRateTextField.inputAccessoryView = toolBar
        estimatedRateChangeTextField.inputAccessoryView = toolBar
        
        homeInsuranceTextField.inputAccessoryView = toolBar
        propertyTaxTextField.inputAccessoryView = toolBar
    }
    
    @objc func nextButtonTapped(button:UIBarButtonItem) -> Void {
        if loanAmountTextField.isFirstResponder {
            downPaymentTextField.becomeFirstResponder()
        } else if downPaymentTextField.isFirstResponder {
            monthlyHOATextField.becomeFirstResponder()
        } else if monthlyHOATextField.isFirstResponder {
            initialInterestRateTextField.becomeFirstResponder()
        } else if initialInterestRateTextField.isFirstResponder {
            maxInterestRateTextField.becomeFirstResponder()
        } else if maxInterestRateTextField.isFirstResponder {
            estimatedRateChangeTextField.becomeFirstResponder()
        } else if estimatedRateChangeTextField.isFirstResponder {
            homeInsuranceTextField.becomeFirstResponder()
        } else if homeInsuranceTextField.isFirstResponder {
            propertyTaxTextField.becomeFirstResponder()
        } else if propertyTaxTextField.isFirstResponder {
            propertyTaxTextField.resignFirstResponder()
        }
    }
    
    @objc func doneButtonTapped(button:UIBarButtonItem) -> Void {
        self.view.endEditing(true)
    }

}

