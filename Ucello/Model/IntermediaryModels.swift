//
//  IntermediaryModels.swift
//  Ucello
//
//  Created by Ian Regino on 4/7/19.
//  Copyright © 2019 Ian Regino. All rights reserved.
//

import Foundation

struct Categories: Codable {
    let categories: [String]
}

struct PreparationTime: Codable {
    let prepTime: Int
    
    enum CodingKeys: String, CodingKey {
        case prepTime = "preparation_time"
    }
}
