//
//  CloudKit.swift
//  DnDInventoryManager
//
//  Created by Adrian Kenepah-Martin on 4/11/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit
import CloudKit

typealias PostCompletion = (Bool) -> ()
//typealias CampaignsCompletion = ([Campaign]?) -> ()
typealias CharactersCompetion = ([Character]?) -> ()
typealias UserIDCompletion = (String) -> ()
typealias ItemsCompletion = ([Item]?) -> ()

class CloudKit {
    
    static let shared = CloudKit()
    
    let container : CKContainer
    let privateDatabase : CKDatabase
    let publicDatabase : CKDatabase
    
    private init() {
        self.container = CKContainer.default()
        self.privateDatabase = self.container.privateCloudDatabase
        self.publicDatabase = self.container.publicCloudDatabase
    }
    
    func saveItem(item: Item, completion: @escaping PostCompletion) {
        let itemRecord = Item.recordFor(item: item)
        self.publicDatabase.save(itemRecord) { (savedRecord, error) in
            if error != nil {
                print(error!.localizedDescription)
                OperationQueue.main.addOperation {
                    completion(false)
                }
            } else {
                print(savedRecord ?? "No saved item")
                OperationQueue.main.addOperation {
                    completion(true)
                }
            }
        }
    }
    
    func saveCharacter(character: Character, completion: @escaping PostCompletion) {
        let characterRecord = Character.recordFor(character: character)
        self.publicDatabase.save(characterRecord) { (savedRecord, error) in
            if error != nil {
                print(error!.localizedDescription)
                OperationQueue.main.addOperation {
                    completion(false)
                }
            } else {
                print(savedRecord ?? "No saved character")
                OperationQueue.main.addOperation {
                    completion(true)
                }
            }
        }
    }
    
//    func save (post: Post, completion: @escaping PostCompletion) {
//        do {
//            if let record = try Post.recordFor(post: post)
//            {
//                
//            }}
//        self.privateDatabase.save(post, completionHandler: { (post, error) in
//            if error != nil {
//                completion(false)
//                return
//            }
//            
//            if let post = post {
//                completion(true)
//            } else {
//                completion(false)
//            }
//        })
//    }
//    
//    func getUserID(completion: @escaping UserIDCompletion) {
//        
//    }
}
