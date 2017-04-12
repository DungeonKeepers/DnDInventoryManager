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
    var text = String()

    
    init?(json: [String : Any]) {
        
        print(json)
        
        if let name = json["name"] as? String, let textJSON = json["text"] as? [Any] {
            self.name = name
            for each in textJSON {
                if let itemText = each as? String {
                    self.text = "\(self.text)\r \(itemText)"
                }
            }
        } else {
            return nil
        }
    }
}

extension Item : Hashable {
    var hashValue: Int {
        return name.hashValue ^ text.hashValue
    }
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name && lhs.text == rhs.text
    }
}
