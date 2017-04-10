//
//  ObsidianPortal.swift
//  DnDInventoryManager
//
//  Created by Mike Miksch on 4/10/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit

typealias ObsidianPortalOAuthCompletion = (Bool) -> ()
typealias FetchCampaignsCompletion = ([Campaign]?) -> ()

enum ObsidianPortalAuthError : Error {
    case extractingCode
}

enum SaveOptions {
    case userDefaults
}

let kOAuthBaseURLString = "https://www.obsidianportal.com/oauth/"

class ObsidianPortal {
    
    private var session: URLSession
    private var components: URLComponents
    
    static let shared = ObsidianPortal()
    
    private init() {
        self.session = URLSession(configuration: .default)
        self.components = URLComponents()
        self.components.scheme = "https"
        self.components.host = "www.obsidianportal.com"
    }
    
}
