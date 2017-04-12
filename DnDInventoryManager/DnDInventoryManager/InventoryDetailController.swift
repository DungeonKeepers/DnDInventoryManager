//
//  InventoryDetailController.swift
//  DnDInventoryManager
//
//  Created by Mike Miksch on 4/12/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit

class InventoryDetailController: UIViewController {
    
    var character : Character!
    var itemIndex : Int!
    var item : (item: Item, count: Int)!

    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemText: UILabel!
    @IBOutlet weak var itemQuantity: UILabel!
    
    @IBAction func minusButtonPressed(_ sender: Any) {
        item.count = item.count - 1
        viewDidLoad()
    }
    @IBAction func plusButtonPressed(_ sender: Any) {
        item.count = item.count + 1
        viewDidLoad()
    }
    @IBAction func saveButtonPressed(_ sender: Any) {
        character.inventory[itemIndex].count = item.count
        self.dismiss(animated: true, completion: nil)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemName.text = item.item.name
        self.itemQuantity.text = "Quantity: \(item.count)"

    }

}
