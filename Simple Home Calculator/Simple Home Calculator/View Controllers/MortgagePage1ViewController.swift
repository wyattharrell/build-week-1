//
//  MortgagePage1ViewController.swift
//  Simple Home Calculator
//
//  Created by Lambda_School_Loaner_259 on 3/1/20.
//  Christopher DeVito
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit

class MortgagePage1ViewController: UIViewController {
    
    // MARK: - Properties
    private let mortgageTypes: [String] = ["Mortgage", "5/1 ARM", "Refinance"]
    var mortgageLoanController = MortgageLoanController.mortgageLoanController
    
    
    // MARK: - IBOutlets
    @IBOutlet var titleImage: UIImageView!
    @IBOutlet var mortgageTypePickerView: UIPickerView!
    @IBOutlet var selectMortgageTypeButton: UIButton!
    

    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mortgageLoanController.loadFromPersistentStore()
        self.mortgageTypePickerView.delegate = self
        self.mortgageTypePickerView.dataSource = self

        selectMortgageTypeButton.layer.cornerRadius = 12
        selectMortgageTypeButton.backgroundColor = UIColor(red:0.00, green:0.51, blue:0.33, alpha:1.0)
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectMortgageTypeSegue" {
            let mortgageTypeIndex = mortgageTypePickerView.selectedRow(inComponent: 0)
            let mortgageType = mortgageTypes[mortgageTypeIndex]
            mortgageLoanController.createMortgageLoan(mortgageType: mortgageType)
            let mortgageP2VC = segue.destination as! MortgageCalculatorViewController
            mortgageP2VC.mortgageLoanController = mortgageLoanController
        }
    }
    
    @IBAction func unwindToHome(sender: UIStoryboardSegue) {
        mortgageLoanController.mortgageLoan = nil
    }

}

extension MortgagePage1ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return mortgageTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return mortgageTypes[row]
    }
}
