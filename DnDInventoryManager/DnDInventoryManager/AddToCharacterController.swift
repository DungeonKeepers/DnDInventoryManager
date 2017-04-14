//
//  AddToCharacterController.swift
//  DnDInventoryManager
//
//  Created by Mike Miksch on 4/14/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit

class AddToCharacterController: UIViewController {
    
    var item : Item!
    var characters = [Character](){
        didSet {
            self.smallCharacterTableView.reloadData()
        }
    }

    @IBOutlet weak var smallCharacterTableView: UITableView!
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllCharacters()
        self.smallCharacterTableView.dataSource = self
        self.smallCharacterTableView.delegate = self
        let smallCharacterCell = UINib(nibName: "SmallCharacterCell", bundle: nil)
        self.smallCharacterTableView.register(smallCharacterCell, forCellReuseIdentifier: SmallCharacterCell.identifier)
        self.smallCharacterTableView.rowHeight = UITableViewAutomaticDimension
        print(characters)
    }
    
    func fetchAllCharacters() {
        CloudKit.shared.fetchAllCharacters() { (characterArray, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            if let characterArray = characterArray {
                self.characters = characterArray
                print(characterArray.first ?? "Fuck... no character.")
                print(self.characters)
            }
        }
    }
    

}

//MARK: UITableViewDataSource
extension AddToCharacterController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SmallCharacterCell.identifier, for: indexPath) as! SmallCharacterCell
        let character = characters[indexPath.row]
        cell.character = character
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = characters[indexPath.row]
        CloudKit.shared.addItemToCharacter(characterName: character.name!, item: item)
        self.dismiss(animated: true, completion: nil)
    }
}
