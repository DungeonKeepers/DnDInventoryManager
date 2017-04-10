//
//  User.swift
//  DnDInventoryManager
//
//  Created by Mike Miksch on 4/10/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import Foundation

class User {
    
    let id : String
    let username : String
    let avatar : String?
    let profileURL : String
    var campaignIDs = [String]()
    
    init(json: [String : Any]) {
        self.id = json["id"] as? String ?? "ID not found"
        self.username = json["username"] as? String ?? "Username not found"
        self.avatar = json["avatar_image_url"] as? String ?? nil
        self.profileURL = json["profile_url"] as? String ?? "Profile URL not found"
        for campaigns in json["campaigns"] as! Array<NSDictionary> {
            let campaignID = campaigns["id"]
            self.campaignIDs.append(campaignID as! String)
        }
    }
    
}
