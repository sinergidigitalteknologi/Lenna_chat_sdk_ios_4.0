# Lenna_chat_sdk_ios_4.0
This is a chat sdk for Ios from <a href="https://lenna.ai">Lenna</a> (PT Sinergi Digital Teknologi)

[![Build Status](https://img.shields.io/badge/platform-iOS-orange.svg)](https://github.com/sinergidigitalteknologi/Lenna_chat_sdk_ios_4.0)

## Installation Cocoapods
[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```
## In Your Podfile
set some library to support Lenna chat sdk Ios.
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






----------------------------
