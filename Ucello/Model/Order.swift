//
//  Order.swift
//  Ucello
//
//  Created by Ian Regino on 4/7/19.
//  Copyright © 2019 Ian Regino. All rights reserved.
//

import Foundation

struct Order: Codable {
    var menuItems: [MenuItem]
    
    init(menuItems: [MenuItem] = []) {
        self.menuItems = menuItems
    }
}
