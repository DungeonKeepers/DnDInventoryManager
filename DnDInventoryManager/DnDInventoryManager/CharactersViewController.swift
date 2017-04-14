//
//  CharactersViewController.swift
//  DnDInventoryManager
//
//  Created by Mike Miksch on 4/11/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit

class CharactersViewController: UIViewController {
    
    var characters = [Character]()
    static let shared = CharactersViewController()
    
    @IBOutlet weak var charactersViewTable: UITableView!
    
    @IBAction func newButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "CharacterCreationController", sender: sender)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.charactersViewTable.dataSource = self
        self.charactersViewTable.delegate = self
        setupTabBarDelegate()
        
        update()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.charactersViewTable.reloadData()
        update()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: segue)
        if segue.identifier == CharacterDetailController.identifier {
            if let selectedIndex = self.charactersViewTable.indexPathForSelectedRow?.row {
                let selectedCharacter = self.characters[selectedIndex]
                
                guard let destinationController = segue.destination as? CharacterDetailController else { return }
                
                destinationController.character = selectedCharacter
            }
        }
    }
    
    func update() {
        self.navigationItem.title = "My Characters"
        let characterCell = UINib(nibName: "CharacterCell", bundle: nil)
        self.charactersViewTable.register(characterCell, forCellReuseIdentifier: CharacterCell.identifier)
        self.charactersViewTable.estimatedRowHeight = 250
        self.charactersViewTable.rowHeight = UITableViewAutomaticDimension
        fetchAllCharacters()

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


//MARK: UIViewControllerTransitioningDelegate
extension CharactersViewController : UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning {
        return CustomTransition(duration: 1.0)
    }
}

//MARK: UITableViewDataSource
extension CharactersViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.identifier, for: indexPath) as! CharacterCell
        
        let character = characters[indexPath.row]
        
        cell.character = character
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: CharacterDetailController.identifier, sender: nil)
    }
}

//MARK: setupTabBarDelegate
extension CharactersViewController : UINavigationControllerDelegate {
    func setupTabBarDelegate() {
        if let tabBarController = self.tabBarController {
            guard let viewControllers = tabBarController.viewControllers else { return }
            guard let charactersViewController = viewControllers[1] as? ItemsViewController else { return }
//            charactersViewController.delegate = self
        }
    }
}

//MARK: ItemsViewControllerDelegate
extension CharactersViewController  {
    func viewController() {
    self.tabBarController?.selectedIndex = 0
    }
}





























