//
//  Character.swift
//  DnDInventoryManager
//
//  Created by Mike Miksch on 4/10/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit
import CloudKit

class Character {
    
    var userID = String()
    var campaignID : String?
    var name : String?
    var inventory = [(item: Item, count: Int)]()
    var avatar : UIImage?
    
    init(){}
}

enum CharacterError : Error {
    case writingImageToData
    case writingDatatoDisc
}

extension Character {
    class func recordFor(character: Character) throws -> CKRecord? {
        if let avatar = character.avatar {
            guard let data = UIImageJPEGRepresentation(avatar, 0.7) else { throw CharacterError.writingImageToData }
        
            do {
                try data.write(to: avatar.path)
                let asset = CKAsset(fileURL: avatar.path)
            
                let characterRecord = CKRecord(recordType: "Character")
                characterRecord.setValue(asset, forKey: "avatar")
                characterRecord.setValue(character.name, forKey: "name")
                characterRecord.setValue(character.inventory, forKey: "inventory")
                characterRecord.setValue(character.userID, forKey: "userID")
                characterRecord.setValue(character.campaignID, forKey: "campaignID")
                
                return characterRecord
                
            } catch {
                throw CharacterError.writingDatatoDisc
            }
        }
    }
}
