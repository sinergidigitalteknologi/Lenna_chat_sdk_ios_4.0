//
//  GenerateId.swift
//  Lenna_chat
//
//  Created by MacBook Air on 10/26/20.
//  Copyright © 2020 lenna. All rights reserved.
//

import Foundation
class GenerateId : NSObject {
    
    func generate()-> String  {
        let deviceID = UUID().uuidString
        print(deviceID)
        return deviceID
        
        }
}
