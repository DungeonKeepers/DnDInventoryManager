//
//  User.swift
//  DnDInventoryManager
//
//  Created by Mike Miksch on 4/10/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import Foundation

class User {
    
    static let shared = User()
    let id : String
    var camapignIDs = [String]()
    
    private init() {
        self.id = UUID().uuidString
//        send self.id to CloudKit

    }
    
}
