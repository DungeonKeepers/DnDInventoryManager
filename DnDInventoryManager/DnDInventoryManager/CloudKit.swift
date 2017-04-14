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
typealias CharacterCompletion = (CKRecord?) -> ()
//typealias CampaignsCompletion = ([Campaign]?) -> ()
typealias CharactersCompetion = ([Character]?) -> ()
typealias UserIDCompletion = (String) -> ()
typealias ItemsCompletion = ([Item]?) -> ()

class CloudKit {
    
    static let shared = CloudKit()
    var characters = [Character]()
    
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
        self.privateDatabase.save(itemRecord) { (savedRecord, error) in
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
    func saveCharacter(character: Character, completion: @escaping CharacterCompletion) {
        let characterRecord = Character.recordFor(character: character)
        self.privateDatabase.save(characterRecord!) { (savedCharacter, error) in
            if error != nil {
                print(error!.localizedDescription)
                OperationQueue.main.addOperation {
                    completion(savedCharacter)
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
                    self.characters.append(character)
                    completion(savedCharacter)
                }
            }
        }
    }
    
    func fetchAllCharacters(completion: @escaping (_ fetchedCharacters: [Character]?, _ error: Error?)-> Void ) {
        var fetchedCharacter = [Character]()
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Character", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
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
                        let predicate = NSPredicate(format: "owningCharacter =%@", recordToMatch)
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
    
    func fetchCharacterBy(characterName: String, completion: @escaping (_ fetchedCharacter: Character?, _ error: Error?)-> Void ) {
        
        let predicate = NSPredicate(format: "name == %@", characterName)
        let query = CKQuery(recordType: "Character", predicate: predicate)
        
        self.privateDatabase.perform(query, inZoneWith: nil) { (fetchedCharacter, error) in
            if error != nil {
                print(".........error in fetchedCharacters...............")
                print(error!.localizedDescription)
            }
            
            if let fetchedCharacter = fetchedCharacter {
                for record in fetchedCharacter {
                    if let character = Character(record: record) {
                        let characterID = record.recordID
                        let recordToMatch = CKReference(recordID: characterID, action: .deleteSelf)
                        let predicate = NSPredicate(format: "owningCharacter =%@", recordToMatch)
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
                            OperationQueue.main.addOperation {
                                completion(character, error)
                            }
                        })
                    }
                }
            }
        }
    }
    
    func addItemToCharacter(characterName: String, item: Item) {
        
        let predicate = NSPredicate(format: "name == %@", characterName)
        let query = CKQuery(recordType: "Character", predicate: predicate)
        
        self.privateDatabase.perform(query, inZoneWith: nil) { (fetchedCharacter, error) in
            if error != nil {
                print(".........error in additemToCharacter...............")
                print(error!.localizedDescription)
            }
            
            if let fetchedCharacter = fetchedCharacter {
                for characterRecord in fetchedCharacter {
                    let itemRecord = Item.recordFor(item: item)
                    itemRecord["owningCharacter"] = CKReference(record: characterRecord, action: .deleteSelf)
                    self.privateDatabase.save(itemRecord, completionHandler: { (savedItem, error) in
                        if error != nil {
                            print("error adding Item to charater line 183")
                            print(error!.localizedDescription)
                        }
                        print(savedItem ?? "item not saved")
                        print("item saved on \(characterName)")
                    })
                }
            }
        }
    }

    func updateItemQuanitityOnCharacter(characterName: String, item: Item) {
        let predicate = NSPredicate(format: "name == %@", characterName)
        let query = CKQuery(recordType: "Character", predicate: predicate)
        
        self.privateDatabase.perform(query, inZoneWith: nil) { (fetchedCharacter, error) in
            if error != nil {
                print(".........error in additemToCharacter...............")
                print(error!.localizedDescription)
            }
            
            if let fetchedCharacter = fetchedCharacter {
                for characterRecord in fetchedCharacter {
                    let predicate = NSPredicate(format: "name == %@ AND owningCharacter == %@", item.name, characterRecord)
                    let query = CKQuery(recordType: "Item", predicate: predicate)
                    self.privateDatabase.perform(query, inZoneWith: nil, completionHandler: { (fetchedItems, error) in
                        
                        for fetchedItemRecord in fetchedItems! {
                            fetchedItemRecord["quantity"] = item.quantity as CKRecordValue
                            self.privateDatabase.save(fetchedItemRecord, completionHandler: { (savedItem, error) in
                                if error != nil {
                                    print("error adding Item to charater line 218")
                                    print(error!.localizedDescription)
                                }
                                print(savedItem ?? "item not saved")
                                print("item saved on \(characterName)")
                            })
                        }
                    })
                }
            }
        }
    }
    
//    func fetchItems(characterRecord: CKRecord) -> [Item]? {
//            if let character = Character(record: characterRecord) {
//                let characterID = characterRecord.recordID
//                let recordToMatch = CKReference(recordID: characterID, action: .deleteSelf)
//                let predicate = NSPredicate(format: "owningCharacter =%@", recordToMatch)
//                let query = CKQuery(recordType: "Item", predicate: predicate)
//                self.privateDatabase.perform(query, inZoneWith: nil, completionHandler: { (fetchedItems, error) in
//                    if error != nil {
//                        print("Error fetching items in characterFetch")
//                        print(error!.localizedDescription)
//                    }
//                    
//                    if let fetchedItems = fetchedItems {
//                        for record in fetchedItems {
//                            if let fetchedItem = Item(record: record) {
//                                print(fetchedItem)
//                                character.inventory.append(fetchedItem)
//                                print(character.inventory.first ?? "Fuck... no character.")
//                            }
//                        }
//                    }
//
//                })
//            }
//
//    }
    
    func updateCharacter(character: Character) {
        let id = character.name
        let recordID = CKRecordID(recordName: id!)
        self.publicDatabase.fetch(withRecordID: recordID) { (characterRecord, error) in
            if error != nil {
                print("Error fetching character to be updated. \(error!.localizedDescription)")
            } else {
                if let characterRecord = characterRecord {
                    characterRecord["name"] = character.name as CKRecordValue?
                    self.publicDatabase.save(characterRecord, completionHandler: { (saveRecord, error) in
                        if error != nil {
                            print("Error saving updated character. \(error!.localizedDescription)")
                        }
                    })
                }
            }
        }
    }
}
//    func udpateItem(character: CKRecord, item: Item) {
//        let 
//    }


