//
//  PotentialHomePurchaseController.swift
//  Simple Home Calculator
//
//  Created by Wyatt Harrell on 3/3/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import Foundation

class PotentialHomePurchaseController {
    
    init() {
        loadFromPersistentStore()
        sort()
    }
    
    var potentialHomes: [PotentialHomePurchase] = []
    
    func create(estimatedHomePrice: Int, piPayment: Int, propertyTax: Int?, insurance: Int?, pmi: Int?, hoa: Int?, otherExpenses: Int?, loanAmount: Int, downPayment: Int, estClosingCosts: Int) {
        potentialHomes.append(PotentialHomePurchase(estimatedHomePrice: estimatedHomePrice, piPayment: piPayment, propertyTax: propertyTax, insurance: insurance, pmi: pmi, hoa: hoa, otherExpenses: otherExpenses, loanAmount: loanAmount, downPayment: downPayment, estClosingCosts: estClosingCosts, date: Date()))
        saveToPersistentStore()
    }
    
    func delete(indexPath: Int) {
        potentialHomes.remove(at: indexPath)
        saveToPersistentStore()
    }

    var persistentFileURL: URL? {
        let fileManager = FileManager.default
        let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let homesURL = documentsDir?.appendingPathComponent("potentialhomes.plist")
        return homesURL
    }

    func saveToPersistentStore() {
        let encoder = PropertyListEncoder()

        do {
            let homesPlist = try encoder.encode(potentialHomes)
            guard let homesURL = persistentFileURL else { return }
            try homesPlist.write(to: homesURL)
        } catch {
            print("Unable to save homes to plist: \(error)")
        }
    }

    func loadFromPersistentStore() {
        guard let homesURL = persistentFileURL else { return }
        let decoder = PropertyListDecoder()
        
        do {
            let homesData = try Data(contentsOf: homesURL)
            let homesArray = try decoder.decode([PotentialHomePurchase].self, from: homesData)
            self.potentialHomes = homesArray
            
        } catch {
            print("Error decoding potential homes: \(error)")
        }
    }
    
    func sort() {
        self.potentialHomes = self.potentialHomes.sorted(by: { $0.date > $1.date })
    }
}
