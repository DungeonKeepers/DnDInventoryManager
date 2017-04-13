//
//  CharacterCreationController.swift
//  DnDInventoryManager
//
//  Created by Mike Miksch on 4/11/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit

class CharacterCreationController: UIViewController {
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var campaignToken: UITextField!
    
    
//    @IBAction func imageTapped(_ sender: Any) {
//        self.presentActionSheet()
//    }
    
    @IBAction func createButtonPressed(_ sender: Any) {
        let newCharacter = Character()
        newCharacter.userID = User.shared.id
        newCharacter.name = nameField?.text ?? "The (wo)man With No Name"
        let item = Item(name: "Super Sword", text: "This sword is REALLY super", quantity: 1)
        newCharacter.inventory = [item]
//        print("Got this far")
        CloudKit.shared.saveCharacter(character: newCharacter, completion: {(success) in })
//        CharactersViewController.shared.characters.append(newCharacter)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func presentImagePickerWith(sourceType: UIImagePickerControllerSourceType) {
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = sourceType
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    func presentActionSheet() {
        let actionSheetController = UIAlertController(title: "Source", message: "Get Picture From Camera Roll?", preferredStyle: .actionSheet)
        
        let cameraRollAction = UIAlertAction(title: "Photo Library", style: .default) { (action) in
            self.presentImagePickerWith(sourceType: .photoLibrary)
        }
        
        let cancelAction = UIAlertAction(title: "cancel", style: .destructive, handler: nil)
    }
}

//MARK: UIImagePickerControllerDelegate
extension CharacterCreationController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageView.image = chosenImage
        }
        dismiss(animated: true, completion: nil)
    }
}
