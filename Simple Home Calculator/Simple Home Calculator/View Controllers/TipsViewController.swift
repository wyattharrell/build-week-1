//
//  TiipsViewController.swift
//  Simple Home Calculator
//
//  Created by Lambda_School_Loaner_259 on 3/4/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit

class TipsViewController: UIViewController {
    
    // MARK: - Properties
    let tipsLoader = TipsLoader.tipsLoader
    private var tipsDictionary: [String : [String]] = [ : ]
    
    
    // MARK: - IBOutlet
    @IBOutlet var tipsTextView: UITextView!
    @IBOutlet var tipsTypeLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tipsLoader.load()
        tipsDictionary = tipsLoader.tips
        
        let randomNumber = Int.random(in: 0..<tipsDictionary.count)
        let randomEntry = tipsDictionary.randomElement()
        guard let randomKey = randomEntry?.key,
            let randomValue = randomEntry?.value
            else { return }
        tipsTextView.text = randomValue[randomNumber]
        tipsTypeLabel.text = randomKey
    }
}
