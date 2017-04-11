//
//  JSONParser.swift
//  DnDInventoryManager
//
//  Created by Adrian Kenepah-Martin on 4/10/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import Foundation

typealias JSONParserCallback = (Bool, [Item]?)->()

class JSONParser {
    
    static var jsonData : Data {
        guard let jsonDataPath = Bundle.main.url(forResource: "ItemInventory", withExtension: "json") else { fatalError("ItemInventory.json does not exist in this bundle.") }
        
        do {
            let itemJSONData = try Data(contentsOf: jsonDataPath)
            
            return itemJSONData
            
        } catch {
            fatalError("Failed to create data from iteJSONPath.")
        }
    }
    
    class func itemsFrom(data: Data, callback: JSONParserCallback) {
        do {
            if let rootObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any], let compendiumObject = rootObject["compendium"] as? [String : Any], let itemsArray = compendiumObject["item"] as? [[String : Any]] {
                var items = [Item]()
                
                for itemDictionary in itemsArray {
                    if let item = Item(json: itemDictionary) {
                        items.append(item)
                    }
                }
                callback(true, items)
            }
        } catch {
            print("Error serlializing JSON.")
            callback(false, nil)
        }
    }
}
