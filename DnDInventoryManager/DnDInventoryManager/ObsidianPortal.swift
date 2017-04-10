//
//  ObsidianPortal.swift
//  DnDInventoryManager
//
//  Created by Mike Miksch on 4/10/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit
import OAuthSwift

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
    
    var oauthswift = OAuth1Swift(
        consumerKey:    consumerKey,
        consumerSecret: consumerSecret,
        requestTokenUrl: "https://www.obsidianportal.com/oauth/request_token",
        authorizeUrl:    "https://www.obsidianportal.com/oauth/authorize",
        accessTokenUrl:  "https://www.obsidianportal.com/oauth/access_token"
    )
    
    func getOAuth(viewController: UIViewController) {
        self.oauthswift.authorizeURLHandler = SafariURLHandler(viewController: viewController, oauthSwift: oauthswift)
        let handle = oauthswift.authorize(
            withCallbackURL: URL(string: "dndinventorymanager://oauth-callback/")!,
            success: { credential, response, parameters in
                print(credential.oauthToken)
                print(credential.oauthTokenSecret)
                print(response?.dataString())
        },
            failure: { error in
                print(error.localizedDescription)
        }
        )
    }
    
}

