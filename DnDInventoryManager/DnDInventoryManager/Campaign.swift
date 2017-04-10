//
//  Campaign.swift
//  DnDInventoryManager
//
//  Created by Mike Miksch on 4/10/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import Foundation

class Campaign {
    
    var id = String()
    let name : String
    let campaignURL : String
    var playerIDs = [String]()
    
    init(json: [String : Any]) {
        self.name = json["name"] as? String ?? "Campaign name not found"
        self.campaignURL = json["campaign_url"] as? String ?? "No campaign URL found"
        for players in json["players"] as! Array<NSDictionary> {
            let playerID = players["id"]
            self.playerIDs.append(playerID as! String)
        }
        
    }
    
}

