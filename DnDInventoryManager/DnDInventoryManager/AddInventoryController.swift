//
//  AddInventoryController.swift
//  DnDInventoryManager
//
//  Created by Mike Miksch on 4/12/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit

//typealias characterCallback = ([Character]) -> ()

class AddInventoryController: UIViewController {
    
    var character : Character!
    
    var allItems = [Item]() {
        didSet {
            self.itemsTableView.reloadData()
        }
    }
    
    var displayItems : [Item]? {
        didSet {
            self.itemsTableView.reloadData()
        }
    }
    
    //Populate all items with CloudKit?
    
    @IBOutlet weak var itemsTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        self.itemsTableView.delegate = self
        
        if allItems.count == 0 {
            JSONParser.itemsFrom(data: JSONParser.jsonData) { (success, items) in
                if success {
                    guard let items = items else { fatalError("Items came back nil") }
                    for item in items {
                        allItems.append(item)
                    }
                }
            }
        }
        
        update()
    }
    
    func update() {
        let itemNib = UINib(nibName: "ItemViewCell", bundle: nil)
        self.itemsTableView.register(itemNib, forCellReuseIdentifier: ItemViewCell.identifier)
        self.itemsTableView.estimatedRowHeight = 50
        self.itemsTableView.dataSource = self
    }
    
    
}


//MARK: UITableViewDataSource
extension AddInventoryController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayItems?.count ?? allItems.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = itemsTableView.dequeueReusableCell(withIdentifier: ItemViewCell.identifier, for: indexPath) as! ItemViewCell
        //let selectedItem = allItems[indexPath.row]
        
        var currentItem : Item
        
        if searchBar.text == "" {
            currentItem = allItems[indexPath.row]
        } else {
            currentItem = displayItems![indexPath.row]
        }
        cell.item = currentItem
        
        //cell.item = selectedItem
        return cell
    }
}

//MARK: UITableViewDelegate {
extension AddInventoryController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = allItems[indexPath.row]
        print(selectedItem)
        //        presentActionSheet(item: selectedItem)
    }
    
    //    func getCharacters(completion: @escaping characterCallback) {
    //        func returnToMain(results: [Character]?) {
    //            OperationQueue.main.addOperation {
    //                completion(results!)
    //            }
    //        }
    //    }
    //
    //
    //    func presentActionSheet(item: Item) {
    //        let actionSheetController = UIAlertController(title: "Add Item?", message: "Please Select Character", preferredStyle: .actionSheet)
    //
    //        let totalChar = CloudKit.shared.characters.count
    //        print(CloudKit.shared.characters)
    //        var actionChar = 0
    //        print ("\(totalChar) TOTAL CHARACTERS COUNT FOUND")
    //
    //        for each in CloudKit.shared.characters {
    //            let action = UIAlertAction(title: each.name, style: .default) { (action) in
    //                each.inventory.append(item)
    //                actionChar += 1
    //                actionSheetController.addAction(action)
    //            }
    //            //actionSheetController.addAction(action)
    //
    //        }
    //        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
    //        actionSheetController.addAction(cancelAction)
    //
    //        if actionChar == totalChar {
    //            self.present(actionSheetController, animated: true, completion: nil)
    //        }
    //    }
    
}

//MARK: UISearchBarDelegate
extension AddInventoryController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.validate() {
            let lastIndex = searchText.index(before: searchText.endIndex)
            searchBar.text = searchText.substring(to: lastIndex)
            
        }
        
        if let searchedText = searchBar.text {
            self.displayItems = self.allItems.filter({($0.name.contains(searchedText))})
        }
        
        if searchBar.text == "" {
            self.displayItems = nil
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.displayItems = nil
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
}
