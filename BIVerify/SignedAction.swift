//
//  SignedAction.swift
//  Verify
//
//  Created by Craig Webster on 14/10/2015.
//  Copyright © 2015 Barking Iguana. All rights reserved.
//

import Foundation

class SignedAction {
    static let PARAMETER_SIGNATURE = "verify_signature"
    static let PARAMETER_PUBLIC_KEY = "verify_public_key"
    
    let intent: Intent
    let signature: Signature
    
    var signedPath:String {
        get {
            let path = intent.path
            let sig = "\(SignedAction.PARAMETER_SIGNATURE)=\(signature.string)"
            let key = "\(SignedAction.PARAMETER_PUBLIC_KEY)=\(signature.key)"
            let qs = "\(sig)&\(key)"
            if path.containsString("?") {
                return "\(path)&\(qs)"
            } else {
                return "\(path)?\(qs)"
            }
        }
    }
    
    init(intent:Intent, signature:Signature) {
        self.intent = intent
        self.signature = signature
    }
}