//
//  CostOfLiving.swift
//  Simple Home Calculator
//
//  Created by Wyatt Harrell on 3/4/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import Foundation

struct State: Codable {
    var State: String
    var costIndex: String
    var costRank: Int
    var groceryCost: String
    var housingCost: String
    var utilitiesCost: String
    var transportationCost: String
    var miscCost: String
}
