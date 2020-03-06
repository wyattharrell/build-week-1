//
//  MortgageLoanLoadQuoteTableViewController.swift
//  Simple Home Calculator
//
//  Created by Lambda_School_Loaner_259 on 3/5/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit

class MortgageLoanLoadQuoteTableViewController: UITableViewController {
    
    // MARK: - Properties
    let mortgageLoanController = MortgageLoanController.mortgageLoanController
    var mortgageLoanArray: [(String, MortgageLoan)] {
        var mlArray: [(String, MortgageLoan)] = []
        for (key, value) in mortgageLoanController.mortgages {
            mlArray.append((key, value))
        }
        return mlArray
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
//    @IBAction func showSegueButtonPressed(_ sender: Any?) {
//        guard let mortgage = mortgageLoanController.mortgageLoan else { return }
//        let mortgageType = mortgage.mortgageType
//        if mortgageType == .mortgage {
//            self.performSegue(withIdentifier: "LoadSavedLoanSegue", sender: nil)
//        } else if mortgageType == .fiveOne {
//            self.performSegue(withIdentifier: "LoadARMSegue", sender: nil)
//        }
//    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mortgageLoanArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SavedCell", for: indexPath) as? MortgageLoanSavedQuoteTableViewCell else { return UITableViewCell() }
        let mortgage = mortgageLoanArray[indexPath.row].1
        cell.mortgage = mortgage
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mortgage = mortgageLoanArray[indexPath.row].1
        let mortgageType = mortgage.mortgageType
        if mortgageType == "Mortgage" {
            self.performSegue(withIdentifier: "LoadSavedLoanSegue", sender: nil)
        } else if mortgageType == "ARM" {
            self.performSegue(withIdentifier: "LoadARMSegue", sender: nil)
        }
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let mortgageName = mortgageLoanArray[indexPath.row].0
            mortgageLoanController.deleteMortgageLoan(savedName: mortgageName)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoadSavedLoanSegue" {
            //let mortgageResultsVC = segue.destination as? MortgageResultsViewController
            guard let index = tableView.indexPathForSelectedRow?.row else { return }
            let mortgage = mortgageLoanArray[index].1
            mortgageLoanController.mortgageLoan = mortgage
        } else if segue.identifier == "LoadARMSegue" {
            guard let index = tableView.indexPathForSelectedRow?.row else { return }
            let mortgage = mortgageLoanArray[index].1
            mortgageLoanController.mortgageLoan = mortgage
        }
    }

}
