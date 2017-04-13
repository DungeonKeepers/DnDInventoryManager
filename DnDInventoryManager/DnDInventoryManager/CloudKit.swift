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
        self.privateDatabase.save(characterRecord!!) { (savedCharacter, error) in
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
                    CloudKit.shared.privateDatabase.save(itemRecord, completionHandler: { (savedItem, error) in
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
    
    func fetchCharacters(characterName: String, completion: @escaping (_ fetchedCharacters: [Character]?, _ error: Error?)-> Void ) {
        var fetchedCharacter = [Character]()
        
        let predicate = NSPredicate(format: "name == %@", characterName)
        let query = CKQuery(recordType: "Character", predicate: predicate)
        
        self.privateDatabase.perform(query, inZoneWith: nil) { (fetchedCharacters, error) in
            if error != nil {
                print(".........error in fetchedCharacters...............")
                print(error!.localizedDescription)
            }
            
            if let fetchedCharacters = fetchedCharacters {
                for record in fetchedCharacters {
                    if let character = Character(record: record) {
                        let listID = record.recordID
                        let recordToMatch = CKReference(recordID: listID, action: .deleteSelf)
                        let predicate = NSPredicate(format: "owningCharacters =%@", recordToMatch)
                        let query = CKQuery(recordType: "Item", predicate: predicate)
                        self.privateDatabase.perform(query, inZoneWith: nil, completionHandler: { (fetchedItems, error) in
                            if error != nil {
                                print("Error fetching items in characterFetch")
                                print(error!.localizedDescription)
                            }
                            
                            if let fetchedItems = fetchedItems {
                                for record in fetchedItems {
                                    if let fetchedItem = Item(record: record) {
                                        print(fetchedItem)
                                        character.inventory.append(fetchedItem)
                                        print(character.inventory.first ?? "Fuck... no character.")
                                    }
                                }
                            }
                            fetchedCharacter.append(character)
                            OperationQueue.main.addOperation {
                                completion(fetchedCharacter, error)
                            }
                        })
                    }
                }
            }
        }
    }
}
