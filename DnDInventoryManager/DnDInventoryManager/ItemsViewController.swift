//
//  ItemsViewController.swift
//  DnDInventoryManager
//
//  Created by Mike Miksch on 4/12/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit

//typealias characterCallback = ([Character]) -> ()

class ItemsViewController: UIViewController {
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: segue)
        if segue.identifier == ItemDetailController.identifier {
            if let selectedIndex = self.itemsTableView.indexPathForSelectedRow?.row {
                let selectedItem = self.displayItems?[selectedIndex] ?? self.allItems[selectedIndex]
                guard let destinationController = segue.destination as? ItemDetailController else {return}
                destinationController.item = selectedItem
            }
        }
    }
    
    func update() {
        let itemNib = UINib(nibName: "ItemViewCell", bundle: nil)
        self.itemsTableView.register(itemNib, forCellReuseIdentifier: ItemViewCell.identifier)
        self.itemsTableView.estimatedRowHeight = 50
        self.itemsTableView.dataSource = self
    }
    
}


//MARK: UITableViewDataSource
extension ItemsViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayItems?.count ?? allItems.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = itemsTableView.dequeueReusableCell(withIdentifier: ItemViewCell.identifier, for: indexPath) as! ItemViewCell
        
        var currentItem : Item
        
        if searchBar.text == "" {
            currentItem = allItems[indexPath.row]
        } else {
            currentItem = displayItems![indexPath.row]
        }
        cell.item = currentItem

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: ItemDetailController.identifier, sender: nil)
    }
    
}

//MARK: UISearchBarDelegate
extension ItemsViewController : UISearchBarDelegate {
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
