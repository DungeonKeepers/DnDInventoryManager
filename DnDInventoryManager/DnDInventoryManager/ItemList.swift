//
//  ItemList.swift
//  DnDInventoryManager
//
//  Created by Mike Miksch on 4/11/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import Foundation


class ItemList {
    static let shared = ItemList()
    var allItems = [Item]()
    
    private init(){}
    
    func addItem(item: Item) {
        self.allItems.append(item)
    }
}
