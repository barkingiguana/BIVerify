//
//  Intent.swift
//  Verify
//
//  Created by Craig Webster on 14/10/2015.
//  Copyright © 2015 Barking Iguana. All rights reserved.
//

import Foundation

class Intent {
    let verb: String
    let rawPath: String
    let parameters: [String: String]
    var path: String {
        get {
            return rawPath + queryString
        }
    }
    var queryString: String {
        get {
            if parameters.isEmpty {
                return ""
            }
            var components = [String]()
            let keys = parameters.keys.sort()
            for key in keys {
                let escapedKey = key.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!
                let escapedValue = parameters[key]!.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!
                components.append("\(escapedKey)=\(escapedValue)")
            }
            return "?" + components.joinWithSeparator("&")
        }
    }
    var string: String {
        get {
            return "\(verb) \(path)"
        }
    }
    
    init(verb:String, path:String, parameters:[String:String]) {
        self.verb = verb
        self.rawPath = path
        self.parameters = parameters
    }
    
    func sign(key:String, secret:String, expiresAt:NSDate) -> SignedAction {
        let signature = Signature(key: key, intent: self, secret: secret, expiresAt: expiresAt)
        return SignedAction(intent: self, signature: signature)
    }
}