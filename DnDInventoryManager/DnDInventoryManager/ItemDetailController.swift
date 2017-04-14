//
//  ItemDetailController.swift
//  DnDInventoryManager
//
//  Created by Mike Miksch on 4/14/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit

class ItemDetailController: UIViewController {
    
    var item: Item!
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemText: UILabel!
    

    @IBAction func addButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "AddToCharacterController", sender: sender)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemName.text = item.name
        self.itemText.text = item.text
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: segue)
        if segue.identifier == AddToCharacterController.identifier {
            guard let destinationController = segue.destination as? AddToCharacterController else {return}
            destinationController.item = item
        }
    }
}
