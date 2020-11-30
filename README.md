# Lenna chat sdk ios (swift 4.0)


This is a chat sdk for Ios from <a href="https://lenna.ai">Lenna</a> (PT Sinergi Digital Teknologi)

[![Build Status](https://img.shields.io/badge/platform-iOS-orange.svg)](https://github.com/sinergidigitalteknologi/Lenna_chat_sdk_ios_4.0)  [![Languages](https://img.shields.io/badge/language-Objective--C%20%7C%20Swift-orange.svg)](https://github.com/sinergidigitalteknologi/Lenna_chat_sdk_ios_4.0)


 Required :  
 - Swift 4.0

## 1. Clone the project
```bash
$ git clone https://github.com/sinergidigitalteknologi/Lenna_chat_sdk_ios_4.0.git
```

## 2. Copy and paste folder Lenna_chat_sdk to your project

![Alt text](https://raw.githubusercontent.com/sinergidigitalteknologi/Lenna_chat_sdk_ios_4.0/master/Screen%20Shot%202020-11-30%20at%209.23.21%20AM.png "a title")

## 3. Add Information Property List in info.plist

![Alt text](https://raw.githubusercontent.com/sinergidigitalteknologi/Lenna_chat_sdk_ios_4.0/master/Screen%20Shot%202020-11-30%20at%209.53.14%20AM.png "a title")



## 4. Installation Cocoapods in your project
[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```
open your project and add pod in your [roject project
```bash
$ pod init
```
set some library to support Lenna chat sdk Ios in podfile
```ruby
target 'YourApp' do
  use_frameworks!

  pod 'Alamofire', ' ~> 4.8.2'
  pod 'CryptoSwift'
  pod 'SwiftyJSON'
  pod 'RealmSwift', '~> 3.18.0'
  pod 'SDWebImage'
  pod 'IQKeyboardManagerSwift'
  pod 'FittedSheets'
  pod 'lottie-ios'

  target 'YourAppTests' do
    inherit! :search_paths
  end
  target 'YourAppUITests' do
  end

end
```

to install depedency / library in pod
```bash
$ pod install
```


## 5. Usage
 - Declaration Class in your controller
```swift
class ViewController: UIViewController {
    var chat = Chats();
```
 - set same configuration in controller
 
```swift
 class ViewController: UIViewController {
        
        var chat = Chats();
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            chat.setAppID(value: "appID")
            chat.setBootID(value: "botId")
            chat.setUserName(value: "name")
            chat.setAppKey(value: "token")
            chat.setLogoBubleChat(value: "ic_profile")
            chat.setLogoTitle(value: "ic_image")
            chat.start(sender : self)
        }
    }
```


## 6. Result
![Alt text](https://raw.githubusercontent.com/sinergidigitalteknologi/Lenna_chat_sdk_ios_4.0/master/Screen%20Shot%202020-11-30%20at%2011.38.21%20AM.png "a title")

----------------------------
### Parameter in Chats


| param | Information |
| ------ | ------ |
| setAppID | to set id aplication  |
| setBootID | to set id bot |
| setUserName | set name users |
| setAppKey | this is secret key to encryption end to end |
| setLogoBubleChat | to set icon to buble chat |
| setLogoTitle | to set icon in header chat page |

<h2><a id="user-content-gradle-setup" class="anchor" aria-hidden="true" href="#gradle-setup"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path></path></svg></a> Contributors </h2>

<table>
<thead>
<tr>
<th align="center"><a href="https://www.coolecho.net" rel="nofollow"><img src="https://avatars1.githubusercontent.com/u/37471218?s=400&u=cbded4af86184e5dbb08433876d7b37ff888d67e&v=4" width="100px;" style="max-width:100%;"><br><sub><b><a href="https://github.com/vikyyahya">Viky Yahya</a></b></sub></a><br><a href="https://github.com/vikyyahya"><g-emoji class="g-emoji" alias="computer" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/1f4bb.png">💻</g-emoji></a> <a href="#" title="Design"><g-emoji class="g-emoji" alias="art" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/1f3a8.png">🎨</g-emoji></a> <a href="#" title="Documentation"><g-emoji class="g-emoji" alias="book" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/1f4d6.png">📖</g-emoji></a> <a href="#"></a></th>

</tr>
</thead>
</table>

