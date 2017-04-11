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

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var inventoryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileImage.image = character.avatar
        self.characterName.text = character.name
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
