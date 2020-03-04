//
//  CostOfLivingController.swift
//  Simple Home Calculator
//
//  Created by Wyatt Harrell on 3/4/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import Foundation

class CostOfLivingController {
    
    var stateInfo: [State] = []
    
    init() {
        load()
        sort()
    }
    
    func load() {
        if let fileLocation = Bundle.main.url(forResource: "data", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                
                let dataFromJson = try jsonDecoder.decode([State].self, from: data)
                self.stateInfo = dataFromJson
                
            } catch {
                print(error)
            }
        }
    }
    
    func sort() {
        self.stateInfo = self.stateInfo.sorted(by: { $0.State < $1.State })
    }
    
}
