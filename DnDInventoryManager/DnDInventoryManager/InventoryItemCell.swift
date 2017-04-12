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
    
    var item : (item: Item, count: Int)! {
        didSet {
            self.quantity.text = "\(item.count)"
            self.itemName.text = item.item.name
            }
            
        }
    
}
