//
//  MortgageLoanController.swift
//  Simple Home Calculator
//
//  Created by Lambda_School_Loaner_259 on 3/1/20.
//  Christopher DeVito
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import Foundation

class MortgageLoanController {
    
    // MARK: - Properties
    static var mortgageLoanController = MortgageLoanController()
    var mortgageLoan: MortgageLoan?
    var mortgages: [String : MortgageLoan] = [:]
    
    
    // MARK: - CRUD
    
    func createMortgageLoan(mortgageType: String) {
        mortgageLoan = MortgageLoan(mortgageType: mortgageType)
    }
    
    func retrieveMortgageLoan(savedAs named: String) {
        if let tempMortgage = mortgages[named] {
            mortgageLoan = tempMortgage
        }
    }
    
    func updateMortgageLoan(mortgageLoan: MortgageLoan,
                            amount: Double,
                            downPayment: Double,
                            interestRate: Double,
                            mortgageLength: Int,
                            monthlyHOA: Double,
                            homeInsurance: Double,
                            propertyTax: Double) {
        self.mortgageLoan?.amount = amount
        self.mortgageLoan?.downPayment = downPayment
        self.mortgageLoan?.interestRate = interestRate
        self.mortgageLoan?.mortgageLength = mortgageLength
        self.mortgageLoan?.monthlyHOA = monthlyHOA
        self.mortgageLoan?.homeInsurance = homeInsurance
        self.mortgageLoan?.propertyTax = propertyTax
        let values = mortgages.values
        if values.contains(mortgageLoan) {
            saveToPersistentStore()
        }
    }
    
    func updateARMLoan(mortgageLoan: MortgageLoan,
                       amount: Double,
                       downPayment: Double,
                       initialInterestRate: Double,
                       maxInterestRate: Double,
                       estRateChange: Double,
                       mortgageLength: Int,
                       initialLength: Int,
                       monthlyHOA: Double,
                       homeInsurance: Double,
                       propertyTax: Double) {
        self.mortgageLoan?.amount = amount
        self.mortgageLoan?.downPayment = downPayment
        self.mortgageLoan?.interestRate = initialInterestRate
        self.mortgageLoan?.maxInterestRate = maxInterestRate
        self.mortgageLoan?.estRateChange = estRateChange
        self.mortgageLoan?.mortgageLength = mortgageLength
        self.mortgageLoan?.initialLength = initialLength
        self.mortgageLoan?.monthlyHOA = monthlyHOA
        self.mortgageLoan?.homeInsurance = homeInsurance
        self.mortgageLoan?.propertyTax = propertyTax
        let values = mortgages.values
        if values.contains(mortgageLoan) {
            saveToPersistentStore()
        }
    }
    
    func saveMortgageLoan(savedName: String) {
        mortgageLoan?.savedName = savedName
        mortgages[savedName] = mortgageLoan!
        saveToPersistentStore()
    }
    
    func deleteMortgageLoan(savedName: String) {
        mortgages[savedName] = nil
        saveToPersistentStore()
    }
    
    func createMortgageArray() {
        if UserDefaults.standard.bool(forKey: .didInitializeMortgagesArray) {
            loadFromPersistentStore()
        } else {
            UserDefaults.standard.set(true, forKey: .didInitializeMortgagesArray)
        }
    }
    
    
    // MARK: - Persistence
    
    private var persistentFileURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documents.appendingPathComponent("mortgageLoans.plist")
    }
    
    func saveToPersistentStore() {
        guard let url = persistentFileURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(mortgages)
            try data.write(to: url)
        } catch {
            print("Error saving Motgage data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        
        let fileManager = FileManager.default
        guard let url = persistentFileURL, fileManager.fileExists(atPath: url.path) else {
            return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            mortgages = try decoder.decode([String : MortgageLoan].self, from: data)
        } catch {
            print("Error loading Mortgage data: \(error)")
        }
    }
    
    
    // MARK: - Other methods
    func calculateMonthlyInterest() -> Double {
        //M = P [ i(1 + i)^n ] / [ (1 + i)^n – 1]
        guard let loanAmount = mortgageLoan?.amount,
            let downPayment = mortgageLoan?.downPayment,
            let interestRate = mortgageLoan?.interestRate,
            let number = mortgageLoan?.mortgageLength
            else { return 0.0 }
        let P = loanAmount - downPayment
        let i = interestRate/100/12
        let n = Double(number*12)
        let numerator = P * (i * pow((1 + i), n))
        let denominator = pow((1 + i), (n)) - 1
        let totalPrincipleAndTax = numerator/denominator
        let principlePerMonth = P/n
        let interest = totalPrincipleAndTax - principlePerMonth
        return interest
    }
    
    func calculateMonthlyPrinciple() -> Double {
        guard let loanAmount = mortgageLoan?.amount,
            let downPayment = mortgageLoan?.downPayment,
            let number = mortgageLoan?.mortgageLength
            else { return 0.0 }
        let P = loanAmount - downPayment
        let n = Double(number*12)
        let principle = P/n
        return principle
    }
    
    func calculateMonthlyInsurance() -> Double {
        guard let insurance = mortgageLoan?.homeInsurance else { return 0.0 }
        let monthlyInsurance = insurance/12
        return monthlyInsurance
    }
    
    func calculateMonthlyTax() -> Double {
        guard let tax = mortgageLoan?.propertyTax else { return 0.0 }
        let monthlyTax = tax/12
        return monthlyTax
    }
    
    func calculateMonthlyHOA() -> Double {
        guard let hoa = mortgageLoan?.monthlyHOA else { return 0.0 }
        return hoa
    }
}
