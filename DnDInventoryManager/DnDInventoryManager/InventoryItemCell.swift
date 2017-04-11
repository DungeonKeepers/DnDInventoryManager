//
//  InventoryItemCell.swift
//  DnDInventoryManager
//
//  Created by Mike Miksch on 4/11/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit

class InventoryItemCell: UITableViewCell {
    
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var itemName: UILabel!
    
    var item : [Item : Int]! {
        didSet {
            for (key, value) in item {
                self.quantity.text = String(value)
                self.itemName.text = key.name
            }
            
        }
    }
    
}
