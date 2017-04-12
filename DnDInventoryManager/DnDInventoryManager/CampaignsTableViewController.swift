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
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
}
