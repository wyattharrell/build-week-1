//
//  MortgageLoanSavedQuoteTableViewCell.swift
//  Simple Home Calculator
//
//  Created by Lambda_School_Loaner_259 on 3/5/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit

class MortgageLoanSavedQuoteTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var mortgage: MortgageLoan? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - IBOutlets
    @IBOutlet var savedQuoteLabel: UILabel!
    
    func updateViews() {
        guard let mortgage = mortgage, let savedQuoteName = mortgage.savedName else { return }
        savedQuoteLabel.text = savedQuoteName
        
    }

}
