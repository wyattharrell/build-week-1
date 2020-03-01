//
//  MortgageLoan.swift
//  Simple Home Calculator
//
//  Created by Lambda_School_Loaner_259 on 3/1/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import Foundation

struct MortgageLoan {
    var amount: Double?
    var mortgageType: String
    var downPayment: Double?
    var interestRate: Double?
    var mortgageLength: Int?
    
    
    init(mortgageType: String, amount: Double?, downPayment: Double?, interestRate: Double? = nil, mortgageLength: Int? = nil) {
        self.amount = amount
        self.mortgageType = mortgageType
        self.downPayment = downPayment
        self.interestRate = interestRate
        self.mortgageLength = mortgageLength
    }
    /* can add:
    property tax
    PMI
    Home Insurance
    Monthly HOA
    Credit rating:
        Excellent (720+)
        Good (620-719)
        Fair (580-619)
        Poor (<580)
    */
}
