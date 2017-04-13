//
//  Items.swift
//  DnDInventoryManager
//
//  Created by Adrian Kenepah-Martin on 4/10/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import Foundation
import CloudKit

class Item {

    let name : String
    var text = String()
    var quantity = 1

    
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
    
    init(name: String, text: String) {
        self.name = name
        self.text = text
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

extension Item {
    class func recordFor(item: Item) -> CKRecord {

        let record = CKRecord(recordType: "Item")
        record.setValue(item.name, forKey: "name")
        record.setValue(item.text, forKey: "text")
        record.setValue(item.quantity, forKey: "quantity")
        return record
    }
}
