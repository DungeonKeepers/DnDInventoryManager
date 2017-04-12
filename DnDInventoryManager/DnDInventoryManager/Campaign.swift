//
//  Campaign.swift
//  DnDInventoryManager
//
//  Created by Adrian Kenepah-Martin on 4/12/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit

class Campaign {
    
    var userID = String()
    var campaignID : String?
    var name : String?
    var img : UIImage?
    
    init() {
        self.campaignID = UUID().uuidString
    }
}
