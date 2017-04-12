//
//  ViewController.swift
//  DnDInventoryManager
//
//  Created by Mike Miksch on 4/10/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit
import OAuthSwift

class ViewController: UIViewController {
    
    var dataSource = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if !Cloud kit value for user ID {
//            User()
//        }
        
//        if !Cloud kit has data for item list {
        
        JSONParser.itemsFrom(data: JSONParser.jsonData) { (success, items) in
            if(success) {
                guard let items = items else { fatalError("Items came back nil.") }
                
                for item in items {
                    ItemList.shared.addItem(item: item)
                }
                dataSource = ItemList.shared.allItems
            }
        }
    }
}

