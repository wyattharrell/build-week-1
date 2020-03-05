//
//  MortgageResultsViewController.swift
//  Simple Home Calculator
//
//  Created by Lambda_School_Loaner_259 on 3/1/20.
//  Christopher DeVito
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit
import Charts

class MortgageResultsViewController: UIViewController {
    
    // MARK: - Properties
    var mortgageLoanController = MortgageLoanController.mortgageLoanController
    var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter
    }
    
    
    // MARK: - IBOutlets
    @IBOutlet var savedNameTextField: UITextField!
    @IBOutlet var resultsPieChart: PieChartView!
    @IBOutlet var saveQuoteButton: UIButton!
    
    
    // MARK: - IBActions
    @IBAction func saveQuoteButton(_ sender: Any) {
        guard let name = savedNameTextField.text else { return }
        mortgageLoanController.saveMortgageLoan(savedName: name)
        let alert = UIAlertController(title: "Success!", message: "Your quote \"\(name)\" has been saved.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        pieChartUpdate()
        
        saveQuoteButton.layer.cornerRadius = 12
        saveQuoteButton.backgroundColor = UIColor(red:0.00, green:0.51, blue:0.33, alpha:1.0)
        
    }
    
    func pieChartUpdate() {
        
        let principleValue = mortgageLoanController.calculateMonthlyPrinciple()
        let interestValue = mortgageLoanController.calculateMonthlyInterest()
        let insuranceValue = mortgageLoanController.calculateMonthlyInsurance()
        let propertyTaxValue = mortgageLoanController.calculateMonthlyTax()
        let hoaValue = mortgageLoanController.calculateMonthlyHOA()
        let totalPayment = principleValue + interestValue + insuranceValue + propertyTaxValue + hoaValue
        
        // Set up pie chart data set
        let principle = PieChartDataEntry(value: principleValue, label: "Principle")
        let interest = PieChartDataEntry(value: interestValue, label: "Interest")
        let insurance = PieChartDataEntry(value: insuranceValue, label: "Home Insurance")
        let propertyTax = PieChartDataEntry(value: propertyTaxValue, label: "Property Tax")
        let hoa = PieChartDataEntry(value: hoaValue, label: "HOA payment")
        let dataSet = PieChartDataSet(entries: [principle, interest, insurance, propertyTax, hoa], label: "Mortgage Payment Breakdown")
        let data = PieChartData(dataSet: dataSet)
        
        // Set up text format
        dataSet.valueColors = [UIColor.black]
        let formatter = DefaultValueFormatter(formatter: currencyFormatter)
        dataSet.valueFormatter = .some(formatter)
        
        // Display pie chart
        resultsPieChart.data = data
        resultsPieChart.chartDescription?.text = "Mortgage Payment Components"
        dataSet.colors = ChartColorTemplates.joyful()

        // Set up center text
        guard let centerTextValue = currencyFormatter.string(for: totalPayment) else { return }
        resultsPieChart.centerText = "Total Payment: " + centerTextValue

        //This must stay at end of function
        resultsPieChart.notifyDataSetChanged()
    }
}
