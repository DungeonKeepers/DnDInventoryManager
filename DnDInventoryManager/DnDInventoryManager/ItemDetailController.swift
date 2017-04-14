//
//  ItemDetailController.swift
//  DnDInventoryManager
//
//  Created by Mike Miksch on 4/14/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit

class ItemDetailController: UIViewController {
    
    var itemIndex : Int!
    var item: Item!
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemText: UILabel!
    
    @IBOutlet weak var test: UIView!

    @IBAction func addButtonPressed(_ sender: Any) {
    }
    
    @IBOutlet weak var backButtonPressed: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemName.text = item.name
        self.itemText.text = item.text

        // Do any additional setup after loading the view.
    }
}
