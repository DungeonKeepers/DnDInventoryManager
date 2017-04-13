//
//  FoundationExtensions.swift
//  DnDInventoryManager
//
//  Created by Mike Miksch on 4/10/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import Foundation

extension String {
    func validate() -> Bool {
        let pattern = "[^0-9a-z]"
        
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            let range = NSRange(location: 0, length: self.characters.count)
            let matches = regex.numberOfMatches(in: self, options: .reportCompletion, range: range)
            if matches > 0 {
                return false
            }
            return true
        } catch {
            return false
        }
    }
}
