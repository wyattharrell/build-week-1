//
//  CanIBuyTableViewController.swift
//  Simple Home Calculator
//
//  Created by Wyatt Harrell on 3/3/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit

class CanIBuyTableViewController: UITableViewController {

    let potentialHomePurchaseController = PotentialHomePurchaseController()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return potentialHomePurchaseController.potentialHomes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PotentialHomeCell", for: indexPath)

        cell.textLabel?.text = "\(dateFormatter.string(from: potentialHomePurchaseController.potentialHomes[indexPath.row].date))"
        cell.detailTextLabel?.text = "Est. Home Price: $\(potentialHomePurchaseController.potentialHomes[indexPath.row].estimatedHomePrice)"

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            potentialHomePurchaseController.delete(indexPath: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCanIBuySearch" {
            guard let CanIBuyResultsVC = segue.destination as? CanIBuyResultsViewController else { return }
            guard let selected = tableView.indexPathForSelectedRow else { return }
            CanIBuyResultsVC.potentialHome = potentialHomePurchaseController.potentialHomes[selected.row]
        }
    }

}
