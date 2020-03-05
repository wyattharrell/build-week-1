//
//  TipsLoader.swift
//  Simple Home Calculator
//
//  Created by Lambda_School_Loaner_259 on 3/4/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import Foundation

public class TipsLoader {
    
    @Published var tips = [String : [String]]()
    
    public static let tipsLoader = TipsLoader()
    
//    init() {
//        load()
//    }
    
    func load() {
        if let fileLocation = Bundle.main.url(forResource: "tips", withExtension: "json") {
            
            // do catch in case of errors
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([String : [String]].self, from: data)
                self.tips = dataFromJson
            } catch {
                print(error)
            }
        }
    }
}
