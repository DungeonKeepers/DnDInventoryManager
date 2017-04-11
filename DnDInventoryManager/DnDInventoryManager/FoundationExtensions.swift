//
//  FoundationExtensions.swift
//  DnDInventoryManager
//
//  Created by Mike Miksch on 4/10/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    func getAccessToken() -> String? {
        guard let token = UserDefaults.standard.string(forKey: "access_token") else { return nil }
        return token
    }
    
    func save(oauthToken: String) -> Bool {
        UserDefaults.standard.set(oauthToken, forKey: "oauth_token")
        return UserDefaults.standard.synchronize()
    }
    
    func save(oauthTokenSecret: String) -> Bool {
        UserDefaults.standard.set(oauthTokenSecret, forKey: "oauth_token_secret")
        return UserDefaults.standard.synchronize()
    }
}
