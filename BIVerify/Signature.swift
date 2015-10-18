//
//  Signature.swift
//  Verify
//
//  Created by Craig Webster on 14/10/2015.
//  Copyright © 2015 Barking Iguana. All rights reserved.
//

import Foundation
import CryptoSwift

class Signature {
    static let DIGEST = "sha256"
    static let SEPARATOR = "--"
    
    let key: String
    let intent:Intent
    let secret:String
    let expiresAt:NSDate
    var string:String {
        get {
            let signedAtSeconds = Int(NSDate().timeIntervalSince1970)
            let expiresAtSeconds = Int(expiresAt.timeIntervalSince1970)
            let string = "\(key)\(expiresAtSeconds)\(signedAtSeconds)\(intent.string)"
            print("STRING: \(string)")
            let token = doHmac(string, key: secret)
            print("TOKEN: \(token)")
            let encodedToken = base64(token)
            print("ENCODED TOKEN: \(encodedToken)")
            let paramsArray: [String] = [
                encodedToken,
                key,
                String(expiresAtSeconds),
                String(signedAtSeconds)
            ]
            let params = paramsArray.joinWithSeparator(Signature.SEPARATOR)
            let result = base64(params)
            return result
        }
    }
    
    init(key:String, intent:Intent, secret:String, expiresAt:NSDate) {
        self.key = key
        self.intent = intent
        self.secret = secret
        self.expiresAt = expiresAt
    }
    
    // TODO: Make this private
    func base64(data: String) -> String {
        let raw = data.dataUsingEncoding(NSUTF8StringEncoding)?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        let result = raw?.stringByReplacingOccurrencesOfString("\\n", withString: "", options: NSStringCompareOptions.RegularExpressionSearch)
        return result!
    }
    
    // TODO: Make this private
    func doHmac(data: String, key: String) -> String {
        let k = [UInt8](key.utf8)
        let authenticator = Authenticator.HMAC(key: k, variant: HMAC.Variant.sha256)
        let hmac = try! data.authenticate(authenticator)
        return hmac
        
        /*
        let k = [UInt8](key.utf8)
        let d = [UInt8](data.utf8)
        //.lazy.map({ $0 as UInt8 })
        let authenticator = Authenticator.HMAC(key: k, variant: HMAC.Variant.sha256)
        let hmac = try! d.authenticate(authenticator)
        return hmac
        */
    }
}