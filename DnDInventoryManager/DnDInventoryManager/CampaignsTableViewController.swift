//
//  CampaignsTableViewController.swift
//  DnDInventoryManager
//
//  Created by Adrian Kenepah-Martin on 4/12/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit
import CloudKit

class CampaignsTableViewController: UITableViewController {
    
    var campaignsList: Array<CKRecord> = []
        
    @IBOutlet weak var campaignsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchCampaigns()
    }
    
    // MARK: fetchCampaigns Function
    func fetchCampaigns() {
        campaignsList = Array<CKRecord>()
        
        let publicDatabase = CKContainer.default().publicCloudDatabase
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Campaigns", predicate: predicate)
        
        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        publicDatabase.perform(query, inZoneWith: nil) { (results, error) in
            if error != nil {
                OperationQueue.main.addOperation {
                    print("Error: \(error.debugDescription)")
                }
            } else {
                if let results = results {
                    for result in results {
                        self.campaignsList.append(result)
                    }
                }
                
                OperationQueue.main.addOperation {
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return campaignsList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CampaignCell", for: indexPath) as UITableViewCell
        let noteRecord: CKRecord = campaignsList[(indexPath.row)]
        
        cell.textLabel?.text = noteRecord.value(forKey: "name") as? String
        cell.imageView?.image = noteRecord.value(forKey: "img") as? UIImage

        return cell
    }
}
