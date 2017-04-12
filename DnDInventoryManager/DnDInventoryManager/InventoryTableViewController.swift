//
//  InventoryTableViewController.swift
//  DnDInventoryManager
//
//  Created by Kent Rogers on 4/11/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit

class InventoryTableViewController: UITableViewController {
    
    var dataSource = [Item]() {
        didSet {
            self.tableView.reloadData()
        }
    }
//    @IBOutlet weak var itemCell: UITableViewCell!
//    
//    @IBOutlet weak var itemName: UILabel!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
}

extension InventoryTableViewController {
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.performSegue(withIdentifier: InventoryTableViewController.identifier, sender: nil)
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemCell
        
        let invItem = self.dataSource[indexPath.row]
        
        cell.itemName.text = invItem.name
        
        return cell
    }
}

//var window: UIWindow?
//    
//var authController : ViewController?
//var repoController : InventoryTableViewController?
//
//func presentAuthController(){
//    if let inventoryViewController = self.window?.rootViewController as? InventoryTableViewController, let storyboard = inventoryViewController.storyboard {
//        if let authViewController = storyboard.instantiateViewController(withIdentifier: ViewController.identifier) as? ViewController {
//            
//            repoViewController.addChildViewController(authViewController)
//            repoViewController.view.addSubview(authViewController.view)
//            
//            authViewController.didMove(toParentViewController: repoViewController)
//            
//            self.authController = authViewController
//            self.repoController = repoViewController
//            
//        }
//    }
//}
