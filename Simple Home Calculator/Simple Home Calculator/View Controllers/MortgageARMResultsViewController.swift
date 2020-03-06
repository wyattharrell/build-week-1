//
//  MortgageARMResultsViewController.swift
//  Simple Home Calculator
//
//  Created by Lambda_School_Loaner_259 on 3/5/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit
import Charts

class MortgageARMResultsViewController: UIViewController {
    
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
    @IBOutlet var initialRatePieChart: PieChartView!
    @IBOutlet var maxRatePieChart: PieChartView!
    @IBOutlet var savedNameTextField: UITextField!
    @IBOutlet var saveButton: UIButton!
    
    
    // MARK: - IBActions
    @IBAction func saveQuote(_ sender: Any) {
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
        
        saveButton.layer.cornerRadius = 12
        saveButton.backgroundColor = UIColor(red:0.00, green:0.51, blue:0.33, alpha:1.0)
    }
    
    func pieChartUpdate() {
        
        let principleValue = mortgageLoanController.calculateMonthlyPrinciple()
        let interestValue = mortgageLoanController.calculateMonthlyInterest()
        let interestValueAtMax = mortgageLoanController.calculateInterestAtMax()
        let insuranceValue = mortgageLoanController.calculateMonthlyInsurance()
        let propertyTaxValue = mortgageLoanController.calculateMonthlyTax()
        let hoaValue = mortgageLoanController.calculateMonthlyHOA()
        let totalInitialPayment = principleValue + interestValue + insuranceValue + propertyTaxValue + hoaValue
        let totalPaymentAtMax = principleValue + interestValueAtMax + insuranceValue + propertyTaxValue + hoaValue
        
    
        // Set up pie chart data set
        let principle = PieChartDataEntry(value: principleValue, label: "Principle")
        let interest = PieChartDataEntry(value: interestValue, label: "Interest")
        let insurance = PieChartDataEntry(value: insuranceValue, label: "Home Insurance")
        let propertyTax = PieChartDataEntry(value: propertyTaxValue, label: "Property Tax")
        let hoa = PieChartDataEntry(value: hoaValue, label: "HOA payment")
        
        let interestAtMax = PieChartDataEntry(value: interestValueAtMax, label: "Interest")
        
        let dataSet = PieChartDataSet(entries: [principle, interest, insurance, propertyTax, hoa], label: "Payment Breakdown For Initial Period")
        let dataSetAtMax = PieChartDataSet(entries: [principle, interestAtMax, insurance, propertyTax, hoa], label: "Payment BreakDown At Max Interest Rate")
        let data = PieChartData(dataSet: dataSet)
        let dataAtMax = PieChartData(dataSet: dataSetAtMax)
    
        // Set up text format
        dataSet.valueColors = [UIColor.black]
        let formatter = DefaultValueFormatter(formatter: currencyFormatter)
        dataSet.valueFormatter = .some(formatter)
        dataSetAtMax.valueColors = [UIColor.black]
        dataSetAtMax.valueFormatter = .some(formatter)
    
        // Display pie chart
        initialRatePieChart.data = data
        initialRatePieChart.chartDescription?.text = "Mortgage Payment Components"
        maxRatePieChart.data = dataAtMax
        maxRatePieChart.chartDescription?.text = "Mortgage Payment at Max Interest Rate"
        dataSet.colors = ChartColorTemplates.joyful()
        dataSetAtMax.colors = ChartColorTemplates.joyful()

        // Set up center text
        guard let centerTextValue = currencyFormatter.string(for: totalInitialPayment) else { return }
        initialRatePieChart.centerText = """
            Total Payment:
            \(centerTextValue)
            """
        guard let centerTextValueAtMax = currencyFormatter.string(for: totalPaymentAtMax) else { return }
        maxRatePieChart.centerText = """
            Total Payment:
            \(centerTextValueAtMax)
            """

        //This must stay at end of function
        initialRatePieChart.notifyDataSetChanged()
        maxRatePieChart.notifyDataSetChanged()
    }

}
