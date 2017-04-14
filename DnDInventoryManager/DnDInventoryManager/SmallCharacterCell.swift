//
//  SmallCharacterCell.swift
//  DnDInventoryManager
//
//  Created by Mike Miksch on 4/14/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit

class SmallCharacterCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    
    var character : Character! {
        didSet {
            self.name.text = character!.name
        }
    }
    
}
