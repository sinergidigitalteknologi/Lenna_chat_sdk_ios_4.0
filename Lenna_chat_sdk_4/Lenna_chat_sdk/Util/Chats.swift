//
//  Chats.swift
//  Lenna_chat
//
//  Created by MacBook Air on 11/4/20.
//  Copyright © 2020 lenna. All rights reserved.
//

import UIKit
import SwiftyJSON

class Chats : UIViewController  {
    var objAPIManager = APIManager()
    var Dc = DecryptAes()

    
     func setAppID (value : String){
        Constan.APP_ID = value

    }
    
     func setBootID (value : String){
        Constan.BOT_ID = value

    }
    
    func setRegKey (value : String){
        Constan.REG_KEY = value

    }
    
    func setSekretKey (value : String){
        Constan.SECRET_KEY = value

    }
    
    func setWebhookKey (value : String){
        Constan.WEBHOOK_KEY = value

    }
    
     func setAppKey (value : String){
        Constan.APP_KEY = value
    }
    
    func setUserName (value : String){
        Constan.USER_NAME = value
    }
    
    func setLogoTitle (value : String){
        Constan.LOGO_TITLE = value
    }
    
    func setLogoBubleChat (value : String){
        Constan.LOGO_BUBLE_CHAT = value
    }
    
    func setKeyFallBack (value : String){
        Constan.KEY_FALLBACK = value
    }
    
    func setRequestMenuFallback (value : String){
        Constan.REQUEST_MENU_FALLBACK = value
    }
    
    func start (sender : Any){
        let app_key = Dc.decryp(value: Constan.APP_KEY, key: "lennachatsdk00000000000000000000")
//        print("lennaEn", app_key)
        let js = JSON.init(parseJSON: app_key)
        Constan.WEBHOOK_KEY = js["WebhookKey"].stringValue
        Constan.REG_KEY = js["RegKey"].stringValue
        Constan.SECRET_KEY = js["SekretKey"].stringValue
       
        objAPIManager.sendRegisterDataToAPI(sender : sender)
        
    }
    
    
    

}
