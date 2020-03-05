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
    
    var maxHousingExpensePercent: Double = 0.28
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculateButton.layer.cornerRadius = 12
        calculateButton.backgroundColor = UIColor(red:0.00, green:0.51, blue:0.33, alpha:1.0)
        addAccessoryView()
    }
    
    @IBAction func expensePercentSegmentedControllTapped(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            maxHousingExpensePercent = 0.28
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
                self.maxHousingExpensePercent = percentage_Double / 100
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        default:
            print("N/A")
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCanIBuyForm" {
            guard let CanIBuyFormVC = segue.destination as? CanIBuyFormViewController else { return }
            
            guard let income = annualIncomeTextField.text, !income.isEmpty else { return }
            
            let result = calculateMaxMonthlyPaymentBasedOnIncome_M1(income: Int(income)!, maxHousingExpense: maxHousingExpensePercent)
            
            CanIBuyFormVC.maxMonthlyPaymentBasedOnIncome_M1 = result
            CanIBuyFormVC.income = Int(income)
        }
    }

    func calculateMaxMonthlyPaymentBasedOnIncome_M1(income: Int, maxHousingExpense: Double) -> Double {
        return Double(income) * maxHousingExpense / 12
    }
}

// MARK: - TextField Toolbar

extension CanIBuyViewController {
    func addAccessoryView() -> Void {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonTapped(button:)))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.items = [flexSpace, doneButton]
        toolBar.tintColor = UIColor(red:0.00, green:0.51, blue:0.33, alpha:1.0)
        annualIncomeTextField.inputAccessoryView = toolBar
    }
    
    @objc func doneButtonTapped(button:UIBarButtonItem) -> Void {
        self.view.endEditing(true)
    }
}
