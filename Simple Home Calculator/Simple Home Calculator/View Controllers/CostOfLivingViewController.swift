//
//  CostOfLivingViewController.swift
//  Simple Home Calculator
//
//  Created by Wyatt Harrell on 3/4/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit

class CostOfLivingViewController: UIViewController {

    @IBOutlet weak var currentStatePickerView: UIPickerView!
    @IBOutlet weak var furtureStatePickerView: UIPickerView!
    @IBOutlet weak var calculateButton: UIButton!
    
    let costOfLiving = CostOfLivingController()
    var currentState: State?
    var futureState: State?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculateButton.layer.cornerRadius = 12
        currentStatePickerView.delegate = self
        currentStatePickerView.dataSource = self
        furtureStatePickerView.dataSource = self
        furtureStatePickerView.delegate = self
    }
    
    @IBAction func calculateButtonTapped(_ sender: Any) {
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCostOfLivingResults" {
            guard let CostOfLivingResultsVC = segue.destination as? CostOfLivingResultsViewController else { return }
            if let currState = currentState {
                CostOfLivingResultsVC.currentState = currState
            } else {
                CostOfLivingResultsVC.currentState = costOfLiving.stateInfo[0]
            }
            if let futrState = futureState {
                CostOfLivingResultsVC.futureState = futrState
            } else {
                CostOfLivingResultsVC.futureState = costOfLiving.stateInfo[0]
            }
        }
        
    }
}

extension CostOfLivingViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return costOfLiving.stateInfo.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let state = costOfLiving.stateInfo[row].State
        return state
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == furtureStatePickerView {
            futureState = costOfLiving.stateInfo[row]
        } else if pickerView == currentStatePickerView {
            currentState = costOfLiving.stateInfo[row]
        }
    }
}

