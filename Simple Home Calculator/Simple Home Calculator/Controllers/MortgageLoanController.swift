//
//  MortgageLoanController.swift
//  Simple Home Calculator
//
//  Created by Lambda_School_Loaner_259 on 3/1/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import Foundation

class MortgageLoanController {
    
    // MARK: - Properties
    static var mortgageLoanController = MortgageLoanController()
    var mortgageLoan: MortgageLoan?
    var mortgages: [MortgageLoan] = []
    
    
    // MARK: - CRUD
    
    func createMortgageLoan(mortgageType: String) {
        mortgageLoan = MortgageLoan(mortgageType: mortgageType)
    }
    
//    func retrieveMortgageLoan() -> MortgageLoan {
//
//    }
    
    func updateMortgageLoan(mortgageLoan: MortgageLoan,
                            amount: Double?,
                            downPayment: Double?,
                            interestRate: Double?,
                            mortgageLength: Int?,
                            savedName: String?,
                            monthlyHOA: Double?,
                            homeInsurance: Double?,
                            propertyTax: Double?) {
        
    }
    
    func deleteMortgageLoan(mortgageLoan: MortgageLoan) {
        guard let index = mortgages.firstIndex(of: mortgageLoan) else { return }
        mortgages.remove(at: index)
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
            mortgages = try decoder.decode([MortgageLoan].self, from: data)
        } catch {
            print("Error loading Mortgage data: \(error)")
        }
    }
}
