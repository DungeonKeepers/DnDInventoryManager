//
//  CharacterCell.swift
//  DnDInventoryManager
//
//  Created by Mike Miksch on 4/11/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit

class CharacterCell: UITableViewCell {

    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    
    var character : Character! {
        didSet {
            self.characterName.text = character.name
            self.characterImage.image = character.avatar
        }
    }
    
}
