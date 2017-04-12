//
//  CloudKit.swift
//  DnDInventoryManager
//
//  Created by Adrian Kenepah-Martin on 4/11/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit
import CloudKit

typealias CampaignCompletion = ([Campaign]?)->()

class CloudKit {

    // MARK: - Properties
    let container: CKContainer
    let database: CKDatabase
    
    // MARK: - Initializers
    init() {
        container = CKContainer.default()
        database = container.publicCloudDatabase
    }
    
    // MARK: fetchCampaignsBabiFüd
    func fetchCampaigns(completion: @escaping CampaignCompletion) {
        let postQuery = CKQuery(recordType: "Campaigns", predicate: NSPredicate(value: true))
        
        self.database.perform(postQuery, inZoneWith: nil) { (records, error) in
            if error != nil {
                OperationQueue.main.addOperation {
                    completion(nil)
                }
                
                if let records = records {
                    var campaigns = [Campaign]()
                    
                    for record in records {
                        let name = record.recordType
                        if let asset = record["img"] as? CKAsset {
                            let path = asset.fileURL.path
                            
                            if let image = UIImage(contentsOfFile: path) != nil {
                                let addCampaign = Campaign(name: name, image: path)
                                campaigns.append(addCampaign)
                            }
                        }
                    }
                    
                    OperationQueue.main.addOperation {
                        completion(campaigns)
                    }
                }
            }
        }
    }
}
