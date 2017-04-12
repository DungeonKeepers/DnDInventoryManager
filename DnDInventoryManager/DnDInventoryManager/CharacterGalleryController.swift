////
////  CharacterGalleryController.swift
////  DnDInventoryManager
////
////  Created by Mike Miksch on 4/11/17.
////  Copyright © 2017 Mike Miksch. All rights reserved.
////
//
//import UIKit
//
//protocol GalleryViewControllerDelegate : class {
//    func galleryController(didSelect image: UIImage)
//}
//
//class CharacterGalleryController: UIViewController {
//    
//    weak var delegate : GalleryViewControllerDelegate?
//    
//    @IBOutlet weak var collectionView: UICollectionView!
//
//    var allCharacters = [Character]() {
//        didSet {
//            self.collectionView.reloadData()
//        }
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.collectionView.delegate = self
//        self.collectionView.dataSource = self
//        self.collectionView.collectionViewLayout = CharacterGalleryFlowLayout(columns: 2)
//
//        // Do any additional setup after loading the view.
//    }
//}
//
////MARK: UICollectioNViewDataSource Extension
//extension CharacterGalleryController : UICollectionViewDataSource, UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.identifier, for: indexPath) as! CharacterCell
//        
//        cell.character = self.allCharacters[indexPath.row]
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return allCharacters.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
//    {
//        guard let delegate = self.delegate else { return }
//        let selectedCharacter = self.allCharacters[indexPath.row]
//    }
//}
