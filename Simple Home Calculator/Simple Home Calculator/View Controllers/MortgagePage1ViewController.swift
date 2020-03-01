//
//  MortgagePage1ViewController.swift
//  Simple Home Calculator
//
//  Created by Lambda_School_Loaner_259 on 3/1/20.
//  Christopher DeVito
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit

class MortgagePage1ViewController: UIViewController {
    
    // MARK: - Properties
    
    
    // MARK: - IBOutlets
    @IBOutlet var titleImage: UIImageView!
    @IBOutlet var mortgageTypePickerView: UIPickerView!
    @IBOutlet var selectMortgageTypeButton: UIButton!
    
    
    // MARK: - IBActions
    

    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        selectMortgageTypeButton.layer.cornerRadius = 12
        selectMortgageTypeButton.backgroundColor = UIColor(red:0.00, green:0.51, blue:0.33, alpha:1.0)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
