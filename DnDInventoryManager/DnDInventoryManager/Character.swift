//
//  Character.swift
//  DnDInventoryManager
//
//  Created by Mike Miksch on 4/10/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import Foundation

class Character {
    
    var id = String()
    let name : String
    let characterURL : String
    let avatarURL : String?
    
    init(json: [String : Any]) {
        self.name = json["name"] as? String ?? "Name Unknown"
        self.characterURL = json["character_url"] as? String ?? "No character URL found"
        self.avatarURL = json["avatar_url"] as? String ?? nil
    }
    
}
