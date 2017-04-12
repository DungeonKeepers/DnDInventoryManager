//
//  Post.swift
//  DnDInventoryManager
//
//  Created by Mike Miksch on 4/12/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import Foundation
import CloudKit

class Post {
    let user : User
    
    init(user: User) {
        self.user = user
    }
    
}

enum PostError : Error {
    case writingDataToDisk
}

extension Post {
    class func recordFor(post: Post) throws -> CKRecord? {
        guard let data = 
        do {
            
        }
    }
}
