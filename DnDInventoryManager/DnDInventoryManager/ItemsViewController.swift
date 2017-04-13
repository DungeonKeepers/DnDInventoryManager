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
        self.performSegue(withIdentifier: ItemViewCell.identifier, sender: nil)
    }
}
