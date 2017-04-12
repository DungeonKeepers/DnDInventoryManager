//
//  Character.swift
//  DnDInventoryManager
//
//  Created by Mike Miksch on 4/10/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit

class Character {
    
    var userID = String()
    var campaignID : String?
    var name : String?
    var inventory = [[Item : Int]]()
    var avatar : UIImage?
    
    init(){}
}
