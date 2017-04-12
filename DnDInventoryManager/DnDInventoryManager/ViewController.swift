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
    
    func presentActionSheet(){
        
        let actionSheetController = UIAlertController(title: "Item Management", message: "What action would you like to perform?", preferredStyle: .actionSheet)
        
        actionSheetController.popoverPresentationController?.sourceView = self.view
        actionSheetController.modalPresentationStyle = .popover
        
        let addItemAction = UIAlertAction(title: "Add Item", style: .default, handler: nil)
        
        let removeItemAction = UIAlertAction(title: "Remove Item", style: .default, handler: nil)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        
        actionSheetController.addAction(addItemAction)
        actionSheetController.addAction(removeItemAction)
        actionSheetController.addAction(cancelAction)
        
        self.present(actionSheetController, animated: true, completion: nil)
        
    }
}

