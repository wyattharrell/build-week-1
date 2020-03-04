//
//  CanIBuyResultsViewController.swift
//  Simple Home Calculator
//
//  Created by Wyatt Harrell on 3/2/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit
import Charts

class CanIBuyResultsViewController: UIViewController {

    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var homePriceLabel: UILabel!
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var monthlyExpensesLabel: UILabel!
    
    var potentialHome: PotentialHomePurchase?
    
    let numberFormatter = NumberFormatter()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        pieChartUpdate()
    }
    
    func updateViews() {
        bannerView.backgroundColor = UIColor(red:0.00, green:0.51, blue:0.33, alpha:1.0)

        guard let potentialHome = potentialHome else { return }
        
        numberFormatter.numberStyle = .decimal
        if let formattedNumber = numberFormatter.string(from: NSNumber(value: potentialHome.estimatedHomePrice)) {
            homePriceLabel.text = "$\(formattedNumber)"
        } else {
            homePriceLabel.text = "$\(potentialHome.estimatedHomePrice)"
        }
        
//        let result = potentialHome.piPayment + potentialHome.propertyTax + potentialHome.insurance + potentialHome.pmi + potentialHome.hoa + potentialHome.otherExpenses + potentialHome.loanAmount + potentialHome.downPayment + potentialHome.estClosingCosts
//        monthlyExpensesLabel.text = "$\(result) /month"
    }
    
    func pieChartUpdate () {
        
        guard let potentialHome = potentialHome else { return }
        var arrayOfEntrys: [PieChartDataEntry] = []

        let entry1 = PieChartDataEntry(value: Double(potentialHome.piPayment), label: "PI Payment")
        arrayOfEntrys.append(entry1)
        
        if let propertyTax = potentialHome.propertyTax, propertyTax != 0 {
            let entry2 = PieChartDataEntry(value: Double(propertyTax), label: "Property Tax")
            arrayOfEntrys.append(entry2)
        }
        
        if let insurance = potentialHome.insurance, insurance != 0 {
            let entry3 = PieChartDataEntry(value: Double(insurance), label: "Insurance")
            arrayOfEntrys.append(entry3)
        }
        
        if let pmi = potentialHome.pmi, pmi != 0 {
            let entry4 = PieChartDataEntry(value: Double(pmi), label: "PMI")
            arrayOfEntrys.append(entry4)
        }
        
        if let hoa = potentialHome.hoa, hoa != 0 {
            let entry5 = PieChartDataEntry(value: Double(hoa), label: "HOA")
            arrayOfEntrys.append(entry5)
        }
        
        if let other = potentialHome.otherExpenses, other != 0 {
            let entry4 = PieChartDataEntry(value: Double(other), label: "Other")
            arrayOfEntrys.append(entry4)
        }
        
        let dataSet = PieChartDataSet(entries: arrayOfEntrys, label: "Expenses")
        let data = PieChartData(dataSet: dataSet)
        pieChart.data = data
        pieChart.chartDescription?.text = "Expenses"

        //All other additions to this function will go here

        //This must stay at end of function
        pieChart.notifyDataSetChanged()
        
        dataSet.colors = ChartColorTemplates.joyful()
        dataSet.valueColors = [UIColor.black]
        pieChart.legend.font = UIFont(name: "Futura", size: 12)!
        pieChart.chartDescription?.font = UIFont(name: "Futura", size: 12)!
//        pieChart.chartDescription?.xOffset = pieChart.frame.width - 50
//        pieChart.chartDescription?.yOffset = pieChart.frame.height * (2/3)
//        pieChart.chartDescription?.textAlign = NSTextAlignment.left

    }
}
