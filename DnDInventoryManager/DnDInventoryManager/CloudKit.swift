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
    
    
// TODO: Fix this shit somehow.
    func saveCharacter(character: Character, completion: @escaping PostCompletion) {
        let characterRecord = try? Character.recordFor(character: character)
        self.publicDatabase.save(characterRecord!!) { (savedCharacter, error) in
            if error != nil {
                print(error!.localizedDescription)
                OperationQueue.main.addOperation {
                    completion(false)
                }
            } else {
                print("Saving Character")
                let inventoryRecord = character.inventory.flatMap { Item.recordFor(item: $0) }
                for itemRecord in inventoryRecord {
                    itemRecord["owningCharacter"] = CKReference(record: savedCharacter!, action: .deleteSelf)
                    CloudKit.shared.publicDatabase.save(itemRecord, completionHandler: { (savedItem, error) in
                        print("Saving items within inventory")
                        debugPrint(error ?? "No error")
                        debugPrint(savedItem ?? "no saved record")
                })
            }
            print(savedCharacter ?? "No saved Character")
                OperationQueue.main.addOperation {
                    completion(true)
                }
            }
        }
    }
}
