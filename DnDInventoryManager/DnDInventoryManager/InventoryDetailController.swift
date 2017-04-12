//
//  InventoryDetailController.swift
//  DnDInventoryManager
//
//  Created by Mike Miksch on 4/12/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit

class InventoryDetailController: UIViewController {
    
    var item : [Item : Int]!

    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemText: UILabel!
    @IBOutlet weak var itemQuantity: UILabel!
    
    @IBAction func minusButtonPressed(_ sender: Any) {
    }
    @IBAction func plusButtonPressed(_ sender: Any) {
    }
    
    @IBOutlet weak var saveButtonPressed: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemName.text = item.keys.
        

        // Do any additional setup after loading the view.
    }

}
