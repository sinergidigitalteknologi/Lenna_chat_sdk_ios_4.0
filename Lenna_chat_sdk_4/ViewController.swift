//
//  ViewController.swift
//  Lenna_chat_sdk_4
//
//  Created by MacBook Air on 11/12/20.
//  Copyright © 2020 lenna. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    var chat = Chats()

    @IBOutlet weak var a: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if self.traitCollection.userInterfaceStyle == .dark {
            a.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//            print("dark 123")
        }
    }
    
    @IBAction func btnChat(_ sender: Any) {
      chat.setAppID(value: "NBVO0y")
      chat.setBootID(value: "PdRgRe")
      chat.setUserName(value: "Pengunjung")
      chat.setAppKey(value: "Wv4oo8YT/c4iyNzX7IS1mfXV+t7jkvWxkwJRXHltSxJtPHfIm62M7cdbaMo8EeeiEFI34cVumyODEHisHRCpD9OSz3OFzJqkSxZKIjitWVDwOllhA9DxBnEvhlO30EOwu6jGxp6PQEsrXsCiG4U4g25leYnPacCBhYCURLCuEx8eGkK2uLFq1WG7L0QKXTPm")
      chat.setLogoBubleChat(value: "ic_profile")
      chat.setLogoTitle(value: "logo_ancol")
      chat.start(sender : self)
    }
    
}

