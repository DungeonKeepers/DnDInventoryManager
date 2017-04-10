//
//  JSONParser.swift
//  DnDInventoryManager
//
//  Created by Adrian Kenepah-Martin on 4/10/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import Foundation

class JSONParser {

    static var jsonData : Data {
        guard let jsonPath = Bundle.main.url(forResource: "iteminventory", withExtension: "json") else { fatalError("iteminventory.json does not exist in this bundle.") }
        
        do {
            let jsonItemData = try Data(contentsOf: jsonPath)
            
            print(jsonItemData)
            return jsonItemData
        } catch {
            fatalError("Failed to create data from jsonPath")
        }
    }
}
