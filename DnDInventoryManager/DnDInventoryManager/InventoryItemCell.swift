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
    
    var item : Item! {
        didSet {
            self.quantity.text = "\(item.quantity)"
            self.itemName.text = item.name
            }
            
        }
    
}
