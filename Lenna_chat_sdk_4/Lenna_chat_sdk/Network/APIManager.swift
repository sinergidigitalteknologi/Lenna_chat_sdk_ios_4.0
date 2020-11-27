//
//  ApiManager.swift
//  Lenna_chat
//
//  Created by MacBook Air on 10/26/20.
//  Copyright © 2020 lenna. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import CryptoSwift
import Foundation

class APIManager: UIViewController {
    
    let baseURL = "https://app.lenna.ai/"
    let interest = ["membaca","menulis"]
    let headersku: HTTPHeaders = [
        "Content-Type":"application/json",
        "Accept": "application/json"]
    static let sharedInstance = APIManager()
    static let getPostsEndpoint = "/posts/"
    var Dc = DecryptAes()
    var CVC = ChatViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    func sendRegisterDataToAPI(sender : Any){
        let token = UserDefaults.standard.string(forKey: Constan.TOKEN) ?? ""
       
        if token == "" {
            var pass = "lenna123"
            let objGenerateId = GenerateId()
            let id =  objGenerateId.generate()
            let ex =  "@goers.com"
            let urlfirst = "backend/api/"
            let appId = Constan.APP_ID
            let urlsecond = "/users/register"
            var paramData = ""
            
            do {
                let aes = try AES(key: Constan.SECRET_KEY, iv: Constan.SECRET_KEY2)
                let ciphertext = try aes.encrypt(Array(pass.utf8))
                pass = ciphertext.toBase64()!
                
            } catch { }
            
            let registerParams : [String : Any] = [
                "name": Constan.USER_NAME,
                "nickname": Constan.USER_NAME,
                "email": id + ex ,
                "phone": "089218930",
                "password": pass,
                "interests": ["lenna","ai"],
                "client": "ios",
                "fcm_token": "token123",
            ]
            //dictionry to json
            let jsonData = try! JSONSerialization.data(withJSONObject: registerParams, options: [])
            let jsonString = String(data: jsonData, encoding: String.Encoding.ascii)!
            print (jsonString)
            let descriptionReq = jsonString
            print(baseURL + urlfirst + appId + urlsecond)
            do {
                let aes = try AES(key: Constan.REG_KEY, iv: Constan.SECRET_KEY2)
                let ctParams = try aes.encrypt(Array(descriptionReq.utf8))
                paramData = ctParams.toBase64()!
                
            } catch let error{
                
                print("error encrpt \(error.localizedDescription)")
            }
            
            let regParam : [String :Any] = [
                "data" : paramData
            ]
            print("regParam \(regParam)")
            
            let request = Alamofire.request(baseURL + urlfirst + appId + urlsecond, method: .post, parameters: regParam,encoding: JSONEncoding.default, headers: headersku)
            request.responseJSON { (data) in
                if(data.value != nil){
                    let registerJSON : JSON = JSON(data.value!)
                    if(registerJSON["data"] != JSON.null){
                        print("registerJSON")
                        self.handleKey(value: registerJSON["data"].stringValue)
                        let story = UIStoryboard(name: "ChatActivity", bundle:nil)
                        let vc = story.instantiateViewController(withIdentifier: "chat") as! ChatViewController
                        UIApplication.shared.windows.first?.rootViewController = vc
                        UIApplication.shared.windows.first?.makeKeyAndVisible()
                        
                        
                    }
                   
                    
                }
            }
            
        }else{
            print("Token udah ada")
            let story = UIStoryboard(name: "ChatActivity", bundle:nil)
            let vc = story.instantiateViewController(withIdentifier: "chat") as! ChatViewController
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
        
    }
    
    func handleKey(value : String){
        
        let res = Dc.decryp(value: value, key: Constan.REG_KEY)
        let js = JSON.init(parseJSON: res)
        print("result\t\(js["status"] )")
        UserDefaults.standard.set(js["access_token"].stringValue, forKey: Constan.TOKEN)
        UserDefaults.standard.set(js["data"]["id"].stringValue, forKey: Constan.ID)
//        CVC.firstChat()
        
    }
    
    /**
    Initializes yusuf function.
    - Parameter iniparam :  ini untuk apa hehehe
    */
    func yusuf(iniparam: String) {
        
        print("yusuf")
    }
    
}
