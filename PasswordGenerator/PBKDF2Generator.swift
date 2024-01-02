//
//  PBKDF2Generator.swift
//  PasswordGenerator
//
//  Created by Karl Kowalski on 1/1/24.
//

import Foundation
import Security
import CryptoKit

class PBKDF2Generator: NSObject, ObservableObject {
    
    override init() {
        super.init()
    }
    
    func generate(password:String, salt:String, iterations:Int) -> Data? {
        
        return nil
    }
}

