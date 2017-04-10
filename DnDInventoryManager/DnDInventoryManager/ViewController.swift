//
//  ViewController.swift
//  DnDInventoryManager
//
//  Created by Mike Miksch on 4/10/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit
import OAuthSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
            ObsidianPortal.shared.getOAuth(viewController: self)
            ObsidianPortal.shared.makeSignedRequest()
        }
}

