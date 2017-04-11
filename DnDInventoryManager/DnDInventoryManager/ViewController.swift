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
    
    class ItemList {
        static let shared = ItemList()
        var allItems = [Item]()
        
        private init(){}
        
        func addItem(item: Item) {
            self.allItems.append(item)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        JSONParser.itemsFrom(data: JSONParser.jsonData) { (success, items) in
            if(success) {
                guard let items = items else { fatalError("Items came back nil.") }
                
                for item in items {
//                    print(item.name)
                    ItemList.shared.addItem(item: item)
                }
                dataSource = ItemList.shared.allItems
            }
        }
        print(dataSource[0].text)
        // Do any additional setup after loading the view, typically from a nib.
    }
}

