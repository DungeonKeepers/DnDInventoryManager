//
//  ItemViewCell.swift
//  DnDInventoryManager
//
//  Created by Mike Miksch on 4/12/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit

class ItemViewCell: UITableViewCell {

    @IBOutlet weak var itemName: UILabel!
    
    var item : Item! {
        didSet {
            self.itemName.text = item.name
        }
    }
    
}
