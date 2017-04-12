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
    
// NEED TO RELINK ALL THESE ACTIONS AND OUTLETS

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var inventoryTableView: UITableView!
    
    @IBAction func dismissButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editButtonClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "EditCharacterController", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileImage.image = character.avatar
        self.characterName.text = character.name
        self.inventoryTableView.reloadData()
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
    }

}

//MARK: UITableViewDataSource
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
