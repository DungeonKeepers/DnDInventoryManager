//
//  CharacterDetailController.swift
//  DnDInventoryManager
//
//  Created by Mike Miksch on 4/11/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit

class CharacterDetailController: UIViewController {
    
    var character : Character!
    
    static var shared = CharacterDetailController()

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var inventoryTableView: UITableView!
    
    @IBAction func dismissButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addItemButtonPressed(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.profileImage.image = character.avatar
        self.characterName.text = character.name
        self.inventoryTableView.delegate = self
        self.inventoryTableView.reloadData()
        update()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        update()
    }
    
    func update() {
        let inventoryItemNib = UINib(nibName: "InventoryItemCell", bundle: nil)
        self.inventoryTableView.register(inventoryItemNib, forCellReuseIdentifier: InventoryItemCell.identifier)
//        self.inventoryTableView.estimatedRowHeight = 50
//        self.inventoryTableView.rowHeight = UITableViewAutomaticDimension
        self.inventoryTableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: segue)
        if segue.identifier == InventoryDetailController.identifier {
            if let selectedIndex = self.inventoryTableView.indexPathForSelectedRow?.row {
                let selectedItem = self.character.inventory[selectedIndex]
                
                guard let destinationController = segue.destination as? InventoryDetailController else { return }
                
                destinationController.character  = character
                destinationController.itemIndex = selectedIndex
                destinationController.item = selectedItem
            }
        }
        
        if segue.identifier == EditCharacterController.identifier {
            guard let destinationController = segue.destination as? EditCharacterController else { return }
            destinationController.currentCharacter = character
        }
    }

}

//MARK: UITableViewDataSource & UITableViewDelegate
extension CharacterDetailController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return character.inventory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InventoryItemCell.identifier, for: indexPath) as! InventoryItemCell
        let inventoryItem = character.inventory[indexPath.row]
        
        cell.item = inventoryItem
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: InventoryDetailController.identifier, sender: self)
    }
}



//MARK: UIViewControllerTransitioningDelegate
extension CharacterDetailController : UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomTransition(duration: 1.0)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomTransition(duration: 1.0)
    }
}
