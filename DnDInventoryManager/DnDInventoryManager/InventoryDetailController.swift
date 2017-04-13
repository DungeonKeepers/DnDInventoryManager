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
    var item : Item!

    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemText: UILabel!
    @IBOutlet weak var itemQuantity: UILabel!
    
    @IBAction func minusButtonPressed(_ sender: Any) {
        item.quantity = item.quantity - 1
        viewDidLoad()
    }
    @IBAction func plusButtonPressed(_ sender: Any) {
        item.quantity = item.quantity + 1
        viewDidLoad()
    }
    @IBAction func saveButtonPressed(_ sender: Any) {
        character.inventory[itemIndex].quantity = item.quantity
        self.dismiss(animated: true, completion: nil)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemName.text = item.name
        self.itemQuantity.text = "Quantity: \(item.quantity)"

    }

}
