//
//  EncryptAes.swift
//  Lenna_chat
//
//  Created by MacBook Air on 11/6/20.
//  Copyright © 2020 lenna. All rights reserved.
//

import Foundation
import CryptoSwift


class EncryptAes {
    
    func encrypt(value:String, key : String) ->  String {
       var data = ""
        do {
            let aes = try AES(key: key, iv: Constan.SECRET_KEY2)
            let ciphertext = try aes.encrypt(Array(value.utf8))
            data = ciphertext.toBase64()!
            return data

        } catch  {
            return ""

        }
    }
}
