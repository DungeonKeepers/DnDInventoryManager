//
//  Items.swift
//  DnDInventoryManager
//
//  Created by Adrian Kenepah-Martin on 4/10/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import Foundation

class Item {

    let name : String
    let text : String
    
    init?(json: [String : Any]) {
        
        print(json)
        
        if let name = json["name"] as? String, let text = json["text"] as? [String] {
            self.name = name
            self.text = text.first ?? "Unknown"
        } else {
            return nil
        }
    }
}
