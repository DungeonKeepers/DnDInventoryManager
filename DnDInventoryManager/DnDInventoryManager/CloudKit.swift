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
    
    func fetchCampaigns(completion: @escaping CampaignCompletion) {
        let postQuery = CKQuery(recordType: "Fetch", predicate: NSPredicate(value: true))
        
        self.database.perform(postQuery, inZoneWith: nil) { (records, error) in
            if error != nil {
                OperationQueue.main.addOperation {
                    completion(nil)
                }
                
                if let records = records {
                    var campaigns = [Campaign]()
                    
                    for record in records {
                        let name = record.recordType
                        if let image = record["image"] as? CKAsset {
                            let path = image.fileURL.path
                            
                            if let image = UIImage(contentsOfFile: path) {
                                let addCampaign = Campaign(name: name, image: image)
                                campaigns.append(addCampaign)
                            }
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
