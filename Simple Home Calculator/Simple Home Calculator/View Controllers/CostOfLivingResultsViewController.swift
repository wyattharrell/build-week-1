//
//  CostOfLivingResultsViewController.swift
//  Simple Home Calculator
//
//  Created by Wyatt Harrell on 3/4/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit

class CostOfLivingResultsViewController: UIViewController {

    var currentState: State?
    var futureState: State?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(currentState?.State)
        print(futureState?.State)
        
    }


}
