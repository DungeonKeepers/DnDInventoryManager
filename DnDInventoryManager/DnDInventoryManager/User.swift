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
//    var campaigns = [Campaign]()
    var characters = [Character]()
    
    private init() {
        self.id = UUID().uuidString
//        send self.id to CloudKit

    }
    
}

//extension User {
//    class func recordFor(post: User) throws -> CKRecord? {
//        guard let data = String else { return }
//        do {
//            try
//        }
//    }
//}
