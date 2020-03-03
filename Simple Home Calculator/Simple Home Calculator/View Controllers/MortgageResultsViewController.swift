//
//  MortgageResultsViewController.swift
//  Simple Home Calculator
//
//  Created by Lambda_School_Loaner_259 on 3/1/20.
//  Christopher DeVito
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit

class MortgageResultsViewController: UIViewController {
    
    // MARK: - Properties
    var mortgageLoanController = MortgageLoanController.mortgageLoanController
    
    
    // MARK: - IBOutlets
    
    
    // MARK: - Temp IBOutlets
    @IBOutlet var amountLabelTemp: UILabel!
    @IBOutlet var typeLabelTemp: UILabel!
    @IBOutlet var downLabelTemp: UILabel!
    @IBOutlet var rateLabelTemp: UILabel!
    @IBOutlet var lengthLabelTemp: UILabel!
    @IBOutlet var hoaLabelTemp: UILabel!
    @IBOutlet var insuranceLabelTemp: UILabel!
    @IBOutlet var taxLabelTemp: UILabel!
    
    // MARK: - IBActions
    
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mortgage = mortgageLoanController.mortgageLoan
        guard let amount = mortgage?.amount,
            let mortgageType = mortgage?.mortgageType,
            let downPayment = mortgage?.downPayment,
            let interestRate = mortgage?.interestRate,
            let mortgageLength = mortgage?.mortgageLength,
            let monthlyHOA = mortgage?.monthlyHOA,
            let homeInsurance = mortgage?.homeInsurance,
            let propertyTax = mortgage?.propertyTax else { return }
        amountLabelTemp.text = "\(amount)"
        typeLabelTemp.text = "\(mortgageType)"
        downLabelTemp.text = "\(downPayment)"
        rateLabelTemp.text = "\(interestRate)"
        lengthLabelTemp.text = "\(mortgageLength)"
        hoaLabelTemp.text = "\(monthlyHOA)"
        insuranceLabelTemp.text = "\(homeInsurance)"
        taxLabelTemp.text = "\(propertyTax)"
    }
    


    // MARK: - Navigation

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        //if segue.identifier == ""
//        // Pass the selected object to the new view controller.
//    }


}
