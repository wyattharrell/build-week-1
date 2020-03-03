//
//  PotentialHomePurchase.swift
//  Simple Home Calculator
//
//  Created by Wyatt Harrell on 3/3/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import Foundation

struct PotentialHomePurchase: Codable {
    let estimatedHomePrice: Int
    let piPayment: Int
    let propertyTax: Int?
    let insurance: Int?
    let pmi: Int?
    let hoa: Int?
    let otherExpenses: Int?
    let loanAmount: Int
    let downPayment: Int
    let estClosingCosts: Int
    let date: Date
}
