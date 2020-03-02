//
//  MortgageLoan.swift
//  Simple Home Calculator
//
//  Created by Lambda_School_Loaner_259 on 3/1/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import Foundation

struct MortgageLoan: Codable {
    var amount: Double?
    var mortgageType: String
    var downPayment: Double?
    var interestRate: Double?
    var mortgageLength: Int?
    var savedName: String?
    
    
    init(mortgageType: String) {
        self.amount = nil
        self.mortgageType = mortgageType
        self.downPayment = nil
        self.interestRate = nil
        self.mortgageLength = nil
        self.savedName = nil
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
