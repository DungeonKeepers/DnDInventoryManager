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
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        update()
    }
    
    func update() {
        self.itemName.text = item.name
        self.itemText.text = item.text
        self.itemQuantity.text = "Quantity: \(item.quantity)"
        if item.quantity == 0 {
            saveButton.setTitle("Remove",for: .normal)
        } else {
            saveButton.setTitle("Save", for: .normal)
        }
        
    }

    @IBAction func minusButtonPressed(_ sender: Any) {
        if item.quantity > 0 {
            item.quantity = item.quantity - 1
        }
        update()
    }
    @IBAction func plusButtonPressed(_ sender: Any) {
        item.quantity = item.quantity + 1
        update()
    }
    @IBAction func saveButtonPressed(_ sender: Any) {
        if item.quantity > 0 {
            CloudKit.shared.updateItemQuanitityOnCharacter(characterName: character.name!, item: item)
            CloudKit.shared.updateCharacter(character: character)
        }
        self.dismiss(animated: true, completion: nil)

//        character.inventory[itemIndex].quantity = item.quantity
//        CloudKit.shared.saveCharacter(character: self.character) { (success) in
//            if success {
//                self.dismiss(animated: true, completion: nil)
//            } else {
//                print("that did NOT save...waaah-waaah-WAAAAAAA")
//            }
//        }
    }

}
