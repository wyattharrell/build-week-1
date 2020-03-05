//
//  MortgageLoan.swift
//  Simple Home Calculator
//
//  Created by Lambda_School_Loaner_259 on 3/1/20.
//  Christopher DeVito
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import Foundation

struct MortgageLoan: Codable, Equatable {
    var amount: Double?
    var mortgageType: String
    var downPayment: Double?
    var interestRate: Double?
    var mortgageLength: Int?
    var savedName: String?
    var monthlyHOA: Double?
    var homeInsurance: Double?
    var propertyTax: Double?
    
    var maxInterestRate: Double?
    var estRateChange: Double?
    var initialLength: Int?
    
    
    init(mortgageType: String) {
        self.amount = nil
        self.mortgageType = mortgageType
        self.downPayment = nil
        self.interestRate = nil
        self.mortgageLength = nil
        self.savedName = nil
        self.monthlyHOA = nil
        self.homeInsurance = nil
        self.propertyTax = nil
        
        self.maxInterestRate = nil
        self.estRateChange = nil
        self.initialLength = nil
    }
}
