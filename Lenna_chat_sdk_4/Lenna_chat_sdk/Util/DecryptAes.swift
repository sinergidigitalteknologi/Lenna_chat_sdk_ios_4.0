//
//  DecryptAes.swift
//  Lenna_chat
//
//  Created by MacBook Air on 11/6/20.
//  Copyright © 2020 lenna. All rights reserved.
//

import Foundation
import CryptoSwift
import SwiftyJSON

class DecryptAes {
    
    func decryp(value : String,key : String) -> String {
        var plText = ""
      
        do {
            
            let utf8str = value.data(using: .utf8)
            
            if let base64Encoded1 = utf8str?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0)) {
//                print("Encoded: \(base64Encoded1)")
                
                if let base64Decoded = Data(base64Encoded: base64Encoded1, options: Data.Base64DecodingOptions(rawValue: 0))
                    .map({ String(data: $0, encoding: .utf8) }) {
                    
                    if let dataWillDecode = base64Decoded {
                        
//                        print("dataWillDecode \(dataWillDecode)")
                        
                        let decypted = try AES(key: Array(key.utf8), blockMode: CBC(iv: Array(Constan.SECRET_KEY2.utf8)) , padding: .pkcs7).decrypt([UInt8](base64: dataWillDecode))
                        
//                        print("ini decryyyppt \(decypted)")
                        
                        let res = String(bytes: decypted, encoding: String.Encoding.utf8)!
                        plText = res
                    }
                }
            }
            return plText
        } catch  {
            return ""
            
        }
    }
}
