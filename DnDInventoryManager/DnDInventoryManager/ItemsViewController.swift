//
//  ItemsViewController.swift
//  DnDInventoryManager
//
//  Created by Mike Miksch on 4/12/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit


class ItemsViewController: UIViewController {
    
    var allItems = [Item]()
    
    //Populate all items with CloudKit?

    @IBOutlet weak var itemsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemsTableView.delegate = self
        self.itemsTableView.dataSource = self

        // Do any additional setup after loading the view.
    }


}


//MARK: UITableViewDataSource
extension ItemsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = itemsTableView.dequeueReusableCell(withIdentifier: ItemViewCell.identifier, for: indexPath) as! ItemViewCell
        let selectedItem = allItems[indexPath.row]
        
        cell.item = selectedItem
        return cell
    }
}

//MARK: UITableViewDelegate {
extension ItemsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = allItems[indexPath.row]
        presentActionSheet(item: selectedItem)
    }
    
    func presentActionSheet(item: Item) {
        let actionSheetController = UIAlertController(title: "Add Item?", message: "Please Select Character", preferredStyle: .actionSheet)
        
        for each in CharactersViewController.shared.characters {
            let action = UIAlertAction(title: each.name, style: .default) { (action) in
                each.inventory.append(item)
            }
            actionSheetController.addAction(action)
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        actionSheetController.addAction(cancelAction)
        
    }
    
}
