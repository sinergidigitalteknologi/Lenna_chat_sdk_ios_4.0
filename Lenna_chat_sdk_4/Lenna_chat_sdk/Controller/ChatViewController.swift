//
//  ChatViewController.swift
//  Lenna_chat
//
//  Created by MacBook Air on 10/26/20.
//  Copyright © 2020 lenna. All rights reserved.
//

import Foundation
import Alamofire
import UIKit
import MessageUI
import CoreLocation
import AVFoundation
import IQKeyboardManagerSwift
import FittedSheets
import WebKit
import EventKitUI
import SwiftyJSON
import Speech
import SDWebImage


class ChatViewController: UIViewController,  UITableViewDelegate,UITextFieldDelegate, UITableViewDataSource, CarouselButtonMessageDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate, PulsaDelegate , confirmMessageDelegate, CLLocationManagerDelegate, ListMessageDelegate{
    
    
    @IBOutlet weak var quickButtonCollection: UICollectionView!
    @IBOutlet weak var chatContainer: UIScrollView!
    @IBOutlet weak var chatMessage: UITextField!
    @IBOutlet weak var sendbutton: UIButton!
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var fakeHeader: UIView!
    @IBOutlet weak var cornerRadius: UIView!
    @IBOutlet weak var mic: UIButton!
    @IBOutlet weak var logoHeader: UIImageView!
    
    @IBOutlet weak var tookBar: UIView!
    
    var userInterfaceStyle : UIUserInterfaceStyle?
    
    
    var player : AVPlayer!
    let alertService = CustomAlertService()
    var base_url = "https://app.lenna.ai/app/public/api/\(Constan.BOT_ID)/webhook/mobile"
    var En = EncryptAes()
    var Dc = DecryptAes()
    
    let locationManager = CLLocationManager()
    
    fileprivate let cellInputMessage = "MessageFromMe"
    fileprivate let cellTextMessage = "MessageText"
    fileprivate let cellImageMessage = "MessageImage"
    fileprivate let cellCarouselMessage = "MessageCarousel"
    fileprivate let cellLoadingMessage = "MessageLoading"
    fileprivate let cellFormMessage = "MessageForm"
    fileprivate let cellFormAirplaneMessage = "MessageAirplaneForm"
    fileprivate let cellConfirmMessage = "MessageConfirm"
    fileprivate let cellPulsaMessage = "MessagePulsa"
    fileprivate let cellMovieMessage = "MessageMovie"
    fileprivate let cellGridMessage = "MessageGrid"
    fileprivate let cellSummaryMessage = "SummaryCell"
    fileprivate let cellAirplaneMessage = "AirplaneCell"
    fileprivate let cellWeatherMessage = "WeatherCell"
    fileprivate let cellHtmlMessage = "MessageHtml"
    fileprivate let cellMessageList = "MessageList"
    
    var messageTextArray : [MessageTextType]  = [MessageTextType]()
    var newMessageArray : [Message] = [Message]()
    var messageFromMe : [MessageInput] = [MessageInput]()
    var arrQuickButton : DataQuickButton!
    
    var messageFromHome = Constan.GREETING_MESSAGE
    var lat = ""
    var long = ""
    var micActive = false
    var isFalback = false
    //speechRecognizer
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "id-ID"))//1
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    var timer = Timer()
    var timer2 = Timer()
    var timer3 = Timer()
    
    //
    
    private var finishedLoadingInitialTableCells = false
    
    override func viewDidAppear(_ animated: Bool) {
        requestTranscribePermissions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        if messageFromHome != "" {
        self.firstChat()
        //        }
        
        if let hasGps =  UserDefaults.standard.object(forKey: "hasGps") as? Bool {
            if hasGps == true {
                print("gps granted access")
            }else {
//                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "nogps")
//                
//                let height = UIScreen.main.bounds.height - UIScreen.main.bounds.height / 5
//                let controller = SheetViewController(controller: vc, sizes: [.fixed(height)])
//                //                controller.topCornersRadius = 15
//                self.present(controller, animated: false, completion: nil)
            }
        }
        
        
        if !hasLocationPermission() {
//            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "nogps")
//
//            let height = UIScreen.main.bounds.height - UIScreen.main.bounds.height / 5
//            let controller = SheetViewController(controller: vc, sizes: [.fixed(height)])
//            controller.cornerRadius = 15
//            self.present(controller, animated: false, completion: nil)
            
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        messageFromHome = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLogoHeader()
        speechRecognizer?.delegate = self as? SFSpeechRecognizerDelegate  //3

        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayback, mode: AVAudioSessionModeDefault)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        if self.traitCollection.userInterfaceStyle == .dark {
            // User Interface is Dark
            if #available(iOS 13.0, *) {
                self.chatMessage.backgroundColor = .secondarySystemBackground
                self.tookBar.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                
                //                leftButton.setImage(#imageLiteral(resourceName: "ic_menu_dark"), for: .normal)
            } else {
                // Fallback on earlier versions
                self.chatMessage.backgroundColor = .white
                //                leftButton.setImage(#imageLiteral(resourceName: "ic_menu"), for: .normal)
                
            }
        } else {
            // User Interface is Light
            self.chatMessage.backgroundColor = .white
            //            leftButton.setImage(#imageLiteral(resourceName: "ic_menu"), for: .normal)
            
        }
        //set cornerRadius
        cornerRadius.layer.cornerRadius = 12
        //set background text field
        chatMessage.layer.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1)
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        //keyboard
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Yay!")
                
            } else {
                print("D'oh")
                //                self.customAlert(title: "error", message: "Alarm not authorize")
                let alertVC = self.alertService.alert(title: "Perhatian !", message: "Izin penggunaan fitur alarm tidak di izinkan", image: "ic_alert_warning", headerColor: "#FF9900", id: 0){
                    // no action
                }
                self.present(alertVC, animated:true)
            }
            
        }
        
        //        UIApplication.shared.statusBarView?.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        if #available(iOS 13.0, *) {
            fakeHeader.backgroundColor = .white
        } else {
            // Fallback on earlier versions
            fakeHeader.backgroundColor = .white
        }
        
        chatTableView.delegate = self
        chatTableView.dataSource = self
        
        chatMessage.delegate = self
        //        chatMessage.setLeftPaddingPoints(10)
        
        chatTableView.register(MessageText.self, forCellReuseIdentifier: cellTextMessage)
        
        chatTableView.register(MessageFromMe.self, forCellReuseIdentifier: cellInputMessage)
        
        chatTableView.register(ChatImage.self, forCellReuseIdentifier: cellImageMessage)
        
        chatTableView.register(MessageForm.self, forCellReuseIdentifier: cellFormMessage)
        
        chatTableView.register(MessageConfirm.self, forCellReuseIdentifier: cellConfirmMessage)
        
        chatTableView.register(MessageLoading.self, forCellReuseIdentifier: cellLoadingMessage)
        
        chatTableView.register(UINib(nibName: "MessageCarousel", bundle: nil), forCellReuseIdentifier: "MessageCarousel")
        
        chatTableView.register(UINib(nibName: "MessageMovie", bundle: nil), forCellReuseIdentifier: "MessageMovie")
        
        chatTableView.register(UINib(nibName: "MessageGrid", bundle: nil), forCellReuseIdentifier: "MessageGrid")
        
        chatTableView.register(UINib(nibName: cellHtmlMessage, bundle: nil), forCellReuseIdentifier: cellHtmlMessage)
        
        
        chatTableView.register(UINib.init(nibName: cellSummaryMessage, bundle: nil), forCellReuseIdentifier: cellSummaryMessage)
        
        chatTableView.register(UINib.init(nibName: cellAirplaneMessage, bundle: nil), forCellReuseIdentifier: cellAirplaneMessage)
        
        
        chatTableView.register(UINib.init(nibName: cellWeatherMessage, bundle: nil), forCellReuseIdentifier: cellWeatherMessage)
        
        chatTableView.register(UINib.init(nibName: cellMessageList, bundle: nil), forCellReuseIdentifier: cellMessageList)
        
        
        configureTableView()
        
        chatTableView.separatorStyle = .none
        
        showNavItem()
        
        
        self.hideKeyboardWhenTappedAround()
        chatMessage.font = UIFont.systemFont(ofSize: 14)
        
        
        //        Listen keyboard event bruh
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.NSHTTPCookieManagerAcceptPolicyChanged, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        //
//        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil) NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        var screenHeight: CGFloat {
            
            return UIScreen.main.bounds.height
        }
        
        print("UIScreen.main.nativeBounds.height",UIScreen.main.nativeBounds.height)
        print("screenheight : ", screenHeight)
        
        quickButtonCollection.delegate = self
        quickButtonCollection.dataSource = self
        quickButtonCollection.register(UINib.init(nibName: "QuickButtonCell", bundle: nil), forCellWithReuseIdentifier: "QuickButtonCell")
        
        let layout = self.quickButtonCollection.collectionViewLayout as! UICollectionViewFlowLayout
        let width = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        layout.itemSize = CGSize(width: (width - 50) / (3), height: 20)
        
        quickButtonCollection.alpha = 0
        
       
    }
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            
            print("latitude = \(location.coordinate.latitude), longitude = \(location.coordinate.longitude)")
            
            lat = String(location.coordinate.latitude)
            long = String(location.coordinate.longitude)
            
            //            let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
            //            getWeatherData(url: WEATHER_URL, parameters: params)
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        let userInterfaceStyle1 = traitCollection.userInterfaceStyle // Either .unspecified, .light, or .dark
        // Update your user interface based on the appearance
        
        if #available(iOS 13.0, *) {
            
            if userInterfaceStyle1 == .dark {
                self.chatMessage.backgroundColor = .secondarySystemBackground
                //               leftButton.setImage(#imageLiteral(resourceName: "ic_menu_dark"), for: .normal)
                print("dark mode")
                
            } else {
                
                self.chatMessage.backgroundColor = .white
                //                leftButton.setImage(#imageLiteral(resourceName: "ic_menu"), for: .normal)
                
            }
        }
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        
        if offset > -30
        {
            if #available(iOS 13.0, *) {
                self.navigationController?.navigationBar.tintColor = .systemBackground
                self.navigationController?.navigationBar.backgroundColor = .systemBackground
                //            UIApplication.shared.statusBarView.backgroundColor = UIColor.white
                fakeHeader.backgroundColor = .systemBackground
                
            } else {
                // Fallback on earlier versions
                self.navigationController?.navigationBar.tintColor = .white
                self.navigationController?.navigationBar.backgroundColor = .white
                //            UIApplication.shared.statusBarView.backgroundColor = UIColor.white
                fakeHeader.backgroundColor = .white
                
            }
            
        }
        else
        {
            self.navigationController?.navigationBar.tintColor = UIColor.clear
            self.navigationController?.navigationBar.backgroundColor = UIColor.clear
            //            UIApplication.shared.statusBarView?.backgroundColor = UIColor.clear
            fakeHeader.backgroundColor = .clear
            
        }
        
    }
    
    @objc func keyboardWillShow(notification: Notification){
        guard let keyboardRect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        if notification.name == NSNotification.Name.UIKeyboardWillShow || notification.name == NSNotification.Name.UIKeyboardWillChangeFrame {
            
            if #available(iOS 13.0, *) {
                fakeHeader.backgroundColor = .systemBackground
            } else {
                // Fallback on earlier versions
                fakeHeader.backgroundColor = .white
            }
            navigationController?.navigationBar.isHidden = true
            
            
            let deviceHeight = UIScreen.main.nativeBounds.height
            
           
            chatTableView.contentInsetAdjustmentBehavior = .never
            chatTableView.contentInset = UIEdgeInsets(top: keyboardRect.height / 1.5, left: 0, bottom: 0, right: 0)
            
            if deviceHeight == 1136 {
                //iPhone 5s, SE, SC
                view.frame.origin.y = -keyboardRect.height / 1.14
            }
            else if deviceHeight == 1334 {
                //iPhone 6, 6s, 7, 8
                view.frame.origin.y = -keyboardRect.height / 1.1
            }
            else if deviceHeight == 1920 || deviceHeight == 2208{
                //iPhone 6+, 6s+, 7+, 8+
                view.frame.origin.y = -keyboardRect.height / 1.13
            }
            else if deviceHeight == 2436 {
                //iPhone X, XS
                view.frame.origin.y = -keyboardRect.height / 1.13
            }
            else if deviceHeight == 1792 {
                //iPhone XR
                view.frame.origin.y = -keyboardRect.height / 1.12
            }
            else if deviceHeight == 2688 {
                //iPhone XS MAX
                view.frame.origin.y = -keyboardRect.height / 1.12
            }
        }
        else
        {
            chatTableView.contentInsetAdjustmentBehavior = .never
            chatTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            view.frame.origin.y = 0
            
            if #available(iOS 13.0, *) {
                fakeHeader.backgroundColor = .systemBackground
            } else {
                // Fallback on earlier versions
                fakeHeader.backgroundColor = .white
            }
            navigationController?.navigationBar.isHidden = false
            
        } //hide keyboard
        
    }
    
    func hasLocationPermission() -> Bool {
        var hasPermission = false
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                hasPermission = false
                UserDefaults.standard.set(false, forKey: "hasGps")
            case .authorizedAlways, .authorizedWhenInUse:
                hasPermission = true
                UserDefaults.standard.set(true, forKey: "hasGps")
            }
        } else {
            hasPermission = false
            UserDefaults.standard.set(false, forKey: "hasGps")
        }
        
        return hasPermission
    }
    
    func CarouselMessageButton(newMessage: String) {
        chatInput(newMessage: newMessage)
        getResponChat(newMessage: newMessage)
    }
    
    func listMessage(newMessage: String) {
        chatInput(newMessage: newMessage)
        getResponChat(newMessage: newMessage)
        
        print("newMessage \(newMessage)")
    }
    
    func MovieOrder(newMessage: String) {
        chatInput(newMessage: newMessage)
        getResponChat(newMessage: newMessage)
        
        print("newMessage \(newMessage)")
    }
    
    
    
    func FormPassnger(newMessage: String) {
        chatInput(newMessage: newMessage)
        getResponChat(newMessage: newMessage)
        
        print("newMessage \(newMessage)")
    }
    
    func HomeMessage(newMessage: String) {
        print("message ",newMessage)
    }
    
    func BeliPulsa(data: String) {
        let DataPulsa = String(data)
        chatInput(newMessage: DataPulsa)
        getResponChat(newMessage: DataPulsa)
    }
    
    func confirmdelegate(newMessage: String) {
        chatInput(newMessage: newMessage)
        getResponChat(newMessage: newMessage)
    }
    
    func airplaneDelegate(newMessage: String) {
        chatInput(newMessage: newMessage)
        getResponChat(newMessage: newMessage)
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chatinfo = newMessageArray[indexPath.row]
        
        if chatinfo.type == "chatInput" {
            let cell : MessageFromMe! = tableView.dequeueReusableCell( withIdentifier: cellInputMessage) as? MessageFromMe
            
            cell.bubleBackgroundView.image = cell.bubbleImage
            cell.messageLabel.textColor = .white
            cell.messageTime.textColor = .white
            
            
            cell.leadingConstraint.isActive = false
            cell.trailingConstraint.isActive = true
            
            cell.messageLabel.text = chatinfo.messageFromMe
            cell.messageTime.text = chatinfo.time
            
            cell.selectionStyle = .none
            return cell
            
        }
        else{
            
            if chatinfo.type == "image" {
                
                let cell : ChatImage! = tableView.dequeueReusableCell( withIdentifier: cellImageMessage) as? ChatImage
                
                
                cell.chatImageController = self
                
                cell.messageImage.sd_setImage(with: URL(string: chatinfo.originalContentUrl), completed: nil)
                cell.messageImage.layer.cornerRadius = 12
                cell.messageImage.layer.masksToBounds = true
                
                cell.leadingConstraint.isActive = true
                cell.trailingConstraint.isActive = false
                
                cell.selectionStyle = .none
                
                
                
                return cell
                
                
            }
            else if chatinfo.type == "text" {
                
                let cell : MessageText! = tableView.dequeueReusableCell( withIdentifier: cellTextMessage) as? MessageText
                
                cell.bubleBackgroundView.image = cell.bubbleImage
                cell.messageLabel.textColor = .black
                cell.messageTime.textColor = .black
                cell.imageCircle.image = cell.cImage!
                let frame = CGRect(x: 5, y: 5, width: 50, height: 50)
                cell.imageCircle.frame = frame
                cell.leadingConstraint.isActive = true
                cell.trailingConstraint.isActive = false
                
                cell.messageLabel.text = chatinfo.messageText
                cell.messageTime.text = chatinfo.time
                
                
                
                cell.selectionStyle = .none
                
                return cell
                
            }
            else if chatinfo.type == "loading" {
                
               let cell : MessageLoading! = tableView.dequeueReusableCell( withIdentifier: cellLoadingMessage) as? MessageLoading
                
                             
                cell.bubleBackgroundView.image = cell.bubbleImage
                cell.animationView.play()
//                cell.messageLabel.text = ". . ."
//                cell.messageLabel.textColor = .black

                cell.bubleBackgroundView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                
                cell.leadingConstraint.isActive = true
                cell.trailingConstraint.isActive = false
                               
                
                cell.selectionStyle = .none
                
                return cell
                
            }
                
            else if chatinfo.type == "action" {
                
                let cell : MessageText! = tableView.dequeueReusableCell( withIdentifier: cellTextMessage) as? MessageText
                
                
                cell.bubleBackgroundView.image = cell.bubbleImage
                cell.messageLabel.textColor = .black
                cell.messageTime.textColor = .black
                
                
                cell.leadingConstraint.isActive = true
                cell.trailingConstraint.isActive = false
                
                if chatinfo.subType == "composeMail" {
                    
                    if chatinfo.emailHasShow == true {
                        let dataEmail = chatinfo.messageComposeEmail
                        
                        sendEmail(email: dataEmail!.emailAddress, cc: dataEmail!.cc, subject: dataEmail!.subject, message: dataEmail!.message)
                        
                        cell.messageLabel.text = "Lenna mencoba mengirim email , coba cek ya"
                        chatinfo.emailHasShow = false
                        
                    }else {
                        chatinfo.emailHasShow = false
                    }
                    
                }
                    
                else if chatinfo.subType == "composeSMS"{
                    
                    if chatinfo.smsHasShow == true {
                        let dataSMS = chatinfo.messageComposeSMS
                        
                        sendSMS(recipient: dataSMS!.recipient, text: dataSMS!.message)
                        cell.messageLabel.text = "Lenna sedang mencoba mengirim SMS , coba cek ya"
                        
                        chatinfo.smsHasShow = false
                    }else {
                        chatinfo.smsHasShow = false
                    }
                    
                }
                    
                else if chatinfo.subType == "makeCall"{
                    if chatinfo.callHasShow == true {
                        let dataCall = chatinfo.messageComposeCall
                        call(number: dataCall!.phoneNumber)
                        cell.messageLabel.text = "Lenna mencoba menelpon \(dataCall!.phoneNumber!)"
                        chatinfo.callHasShow = false
                    }else {
                        chatinfo.callHasShow = false
                    }
                }
                    
                else if chatinfo.subType == "setAlarm"{
                    if chatinfo.scheduleHasShow == true {
                        
                        let dataSchedule = chatinfo.messageSchedule
                        
                        cell.messageLabel.text = "Lenna berhasil membuat alarm pukul \(dataSchedule!.hours!):\(dataSchedule!.minutes!)"
                        self.scheduleNotification(titleAlarm: "Lenna Alarm", bodyAlarm: dataSchedule!.alarmMessage, hour: Int(dataSchedule!.hours)!, minutes: Int(dataSchedule!.minutes)!)
                        
                        chatinfo.scheduleHasShow = false
                    }else {
                        chatinfo.scheduleHasShow = false
                    }
                }
                    
                else if chatinfo.subType == "setSchedule"{
                    if chatinfo.reminderHasShow == true {
                        
                        let dataReminder = chatinfo.messageReminder
                        
                        cell.messageLabel.text = "Lenna berhasil membuat jadwal pukul \(dataReminder!.reminderDate!) \(dataReminder!.reminderTime!)"
                        
                        self.reminderNotification(reminderTitle: dataReminder!.reminderTitle, reminderDate: dataReminder!.reminderDate, reminderTime: dataReminder!.reminderTime)
                        
                        chatinfo.reminderHasShow = false
                    }else {
                        chatinfo.reminderHasShow = false
                    }
                }
                    
                else {
                    if chatinfo.openAppHasShow == true {
                        let dataApp = chatinfo.messageOpenApp
                        openApp(app: dataApp!.packageName)
                        cell.messageLabel.text = "Lenna mencoba membuka \(dataApp!.packageName)"
                        chatinfo.openAppHasShow = false
                    }else {
                        chatinfo.openAppHasShow = false
                    }
                    
                }
                
                cell.messageTime.text = chatinfo.time
                
                cell.selectionStyle = .none
                
                return cell
                
            }
                
            else if chatinfo.type == "confirm" {
                let cell : MessageConfirm! = tableView.dequeueReusableCell( withIdentifier: cellConfirmMessage) as? MessageConfirm
                
                cell.bubleBackgroundView.image = cell.bubbleImage
                cell.messageLabel.textColor = .black
                cell.messageTime.textColor = .black
                
                cell.leadingConstraint.isActive = true
                cell.trailingConstraint.isActive = false
                
                for arrConfirm in chatinfo.messageConfirm {
                    cell.selectionStyle = .none
                    
                    
                    let alertVC = alertService.confirmationAlert(title: arrConfirm.type, message: arrConfirm.text, headerColor: "#FF9900")
                    {
                        for arrAction in arrConfirm.actions {
                            cell.messageLabel.text = "Anda memilih \(arrAction.text!)"
                            cell.messageTime.text = chatinfo.time
                        }
                    }
                    
                    alertVC.confirmDelegate = self
                    
                    if chatinfo.confirmHasShow == true {
                        
                        self.present(alertVC, animated:true)
                        
                        chatinfo.confirmHasShow = false
                    }else {
                        chatinfo.confirmHasShow = false
                    }
                    
                }
                
                return cell
                
            }
                
            else if chatinfo.type == "grid" {
                
                let cell : MessageGrid! = tableView.dequeueReusableCell( withIdentifier: cellGridMessage) as? MessageGrid
                
                cell.pulsaDelegate = self
                
                for arrGrid in chatinfo.messageGrid {
                    if arrGrid.imageUrl != nil {
                        cell.titleImage.sd_setImage(with: URL(string : arrGrid.imageUrl), completed: nil)
                    }
                    
                    cell.titleLabel.text = arrGrid.subTitle
                    
                    if arrGrid.columns != nil {
                        cell.arrGrid = arrGrid.columns
                    }
                    
                }
                
                cell.selectionStyle = .none
                
                cell.gridImage.reloadData()
                return cell
                
            }
                
            else if chatinfo.type == "carousel"{
                
                let cell : MessageCarousel! = tableView.dequeueReusableCell( withIdentifier: cellCarouselMessage) as? MessageCarousel
                
                for arrCarousel in chatinfo.messageCarousel {
                    if arrCarousel.columns != nil {
                        cell.arrCarousel = arrCarousel.columns
                    }
                    
                }
                
                cell.carouselImage.reloadData()
                
                cell.btnMessageDelegate = self
                
                cell.selectionStyle = .none
                
                return cell
                
                
            }
                
            else if chatinfo.type == "list"{
                
                let cell : MessageList! = tableView.dequeueReusableCell( withIdentifier: cellMessageList) as? MessageList
                
                for arrCarousel in chatinfo.messageList {
                    if arrCarousel.columns != nil {
                        cell.arrList = arrCarousel.columns
                        cell.imagePaket.sd_setImage(with: URL(string: arrCarousel.imageUrl), completed: nil)
                    }
                    
                }
                
                cell.listmessage = self
                
                cell.collectionList.reloadData()
                
                cell.selectionStyle = .none
                
                return cell
                
                
            }
                
                
            else if chatinfo.type == "movie"{
                
                let cell : MessageMovie! = tableView.dequeueReusableCell( withIdentifier: cellMovieMessage) as? MessageMovie
                
                for arrMovie in chatinfo.messageMovieCarousel {
                    if arrMovie.columns != nil {
                        cell.arrMovieCarousel = arrMovie.columns
                    }
                }
                
                cell.selectionStyle = .none
                
                cell.carouselImage.reloadData()
                
                return cell
                
                
            }
                
                
                
            else if chatinfo.type == "form" {
                
                let cell : MessageForm! = tableView.dequeueReusableCell( withIdentifier: cellFormMessage) as? MessageForm
                
                
                cell.bubleBackgroundView.image = cell.bubbleImage
                cell.messageLabel.textColor = .black
                cell.messageTime.textColor = .black
                
                cell.leadingConstraint.isActive = true
                cell.trailingConstraint.isActive = false
                
                
                if chatinfo.formHasShow == true {
                    
                    cell.messageLabel.text = "Form"
                    cell.messageTime.text = chatinfo.time
                    
                    //                    let controller = SheetViewController(controller: UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FormAirplane"), sizes: [.fullScreen])
                    //                    controller.topCornersRadius = 15
                    //                    self.present(controller, animated: false, completion: nil)
                    
                    chatinfo.formHasShow = false
                    
                }else {
                    chatinfo.formHasShow = false
                }
                
                cell.selectionStyle = .none
                
                return cell
                
            }
                
                
            else if chatinfo.type == "summary" {
                let cell : SummaryCell = tableView.dequeueReusableCell(withIdentifier: cellSummaryMessage, for: indexPath) as! SummaryCell
                
                for arrSummary in chatinfo.messageSummary {
                    if arrSummary.columns != nil {
                        cell.imageSummary.sd_setImage(with: URL(string: arrSummary.imageUrl), placeholderImage: #imageLiteral(resourceName: "no_image"), completed: nil)
                        cell.arrSummaryInfo = arrSummary.columns
                        cell.summaryTable.reloadData()
                        
                        print("data summary ",arrSummary)
                    }
                }
                
                cell.selectionStyle = .none
                
                return cell
            }
                
                
            else if chatinfo.type == "weather" {
                let cell : WeatherCell = tableView.dequeueReusableCell(withIdentifier: cellWeatherMessage, for: indexPath) as! WeatherCell
                
                for arrWeather in chatinfo.messageWeather {
                    
                    if arrWeather.area != nil {
                        cell.areaLabel.text = arrWeather.area+", "+arrWeather.countryCode
                        cell.daelabel.text = arrWeather.columns[0].longDate
                        cell.TopImageDay.sd_setImage(with: URL(string: arrWeather.columns[0].dayIconUrl), completed: nil)
                        cell.topImageNight.sd_setImage(with: URL(string: arrWeather.columns[0].nightIconUrl), completed: nil)
                        cell.topLabelTemp.text = "\(arrWeather.columns[0].temperature!)°"
                        cell.topMinTempLabel.text = "Min \(arrWeather.columns[0].minTemperature!)°"
                        cell.topMaxTempLabel.text = "Max \(arrWeather.columns[0].maxTemperature!)°"
                        cell.topDayWeatherLabel.text = arrWeather.columns[0].dayWeather
                        cell.topNightWeatherLabel.text = arrWeather.columns[0].nightWeather
                        
                        cell.day1.text = arrWeather.columns[0].shortDate
                        cell.day2.text = arrWeather.columns[1].shortDate
                        cell.day3.text = arrWeather.columns[2].shortDate
                        cell.day4.text = arrWeather.columns[3].shortDate
                        cell.day5.text = arrWeather.columns[4].shortDate
                        
                        cell.daytemp1.text = "\(arrWeather.columns[0].maxTemperature!)° \(arrWeather.columns[0].minTemperature!)°"
                        cell.daytemp2.text = "\(arrWeather.columns[1].maxTemperature!)° \(arrWeather.columns[1].minTemperature!)°"
                        cell.daytemp3.text = "\(arrWeather.columns[2].maxTemperature!)° \(arrWeather.columns[2].minTemperature!)°"
                        cell.daytemp4.text = "\(arrWeather.columns[3].maxTemperature!)° \(arrWeather.columns[3].minTemperature!)°"
                        cell.daytemp5.text = "\(arrWeather.columns[4].maxTemperature!)° \(arrWeather.columns[4].minTemperature!)°"
                        
                        cell.nighttemp1.text = "\(arrWeather.columns[0].maxTemperature!)° \(arrWeather.columns[0].minTemperature!)°"
                        cell.nighttemp2.text = "\(arrWeather.columns[1].maxTemperature!)° \(arrWeather.columns[1].minTemperature!)°"
                        cell.nighttemp3.text = "\(arrWeather.columns[2].maxTemperature!)° \(arrWeather.columns[2].minTemperature!)°"
                        cell.nighttemp4.text = "\(arrWeather.columns[3].maxTemperature!)° \(arrWeather.columns[3].minTemperature!)°"
                        cell.nighttemp5.text = "\(arrWeather.columns[4].maxTemperature!)° \(arrWeather.columns[4].minTemperature!)°"
                        
                        cell.dayimage1.sd_setImage(with: URL(string: arrWeather.columns[0].dayIconUrl), completed: nil)
                        cell.dayimage2.sd_setImage(with: URL(string: arrWeather.columns[1].dayIconUrl), completed: nil)
                        cell.dayimage3.sd_setImage(with: URL(string: arrWeather.columns[2].dayIconUrl), completed: nil)
                        cell.dayimage4.sd_setImage(with: URL(string: arrWeather.columns[3].dayIconUrl), completed: nil)
                        cell.dayimage5.sd_setImage(with: URL(string: arrWeather.columns[4].dayIconUrl), completed: nil)
                        
                        cell.nightimage1.sd_setImage(with: URL(string: arrWeather.columns[0].nightIconUrl), completed: nil)
                        cell.nightimage2.sd_setImage(with: URL(string: arrWeather.columns[1].nightIconUrl), completed: nil)
                        cell.nightimage3.sd_setImage(with: URL(string: arrWeather.columns[2].nightIconUrl), completed: nil)
                        cell.nightimage4.sd_setImage(with: URL(string: arrWeather.columns[3].nightIconUrl), completed: nil)
                        cell.nightimage5.sd_setImage(with: URL(string: arrWeather.columns[4].nightIconUrl), completed: nil)
                    }
                    
                }
                
                cell.selectionStyle = .none
                
                return cell
            }
                
            else if chatinfo.type == "html" {
                let cell : MessageHtml = tableView.dequeueReusableCell(withIdentifier: cellHtmlMessage, for: indexPath) as! MessageHtml
                
                for arrHtml in chatinfo.messageHtml {
                    if arrHtml.html != nil {
                        let data = Data(arrHtml.html.utf8)
                        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                            cell.htmlData.attributedText = attributedString
                            //set  wrapcontent
                            cell.htmlData.translatesAutoresizingMaskIntoConstraints = true
                            cell.htmlData.font =  UIFont(name: "SFProText-Regular", size: 16)!
                            cell.htmlData.sizeToFit()
                            cell.htmlData.isScrollEnabled = false
                        }
                        
                    }
                }
                
                cell.selectionStyle = .none
                
                return cell
            }
                
            else {
                
                let cell : MessageLoading! = tableView.dequeueReusableCell( withIdentifier: cellLoadingMessage) as? MessageLoading
                
                cell.bubleBackgroundView.image = cell.bubbleImage
                
                cell.bubleBackgroundView.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.968627451, blue: 0.9725490196, alpha: 1)
                cell.messageLabel.textColor = .black
                
                
                cell.leadingConstraint.isActive = true
                cell.trailingConstraint.isActive = false
                
                cell.selectionStyle = .none
                
                cell.messageLabel.text = "Maaf Lenna belum tahu"
                return cell
                
                
                
            }
            
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return newMessageArray.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == newMessageArray.count - 1 {
            
            // animasi untuk curveEaseInOut di last index
            
            //            cell.transform = CGAffineTransform(translationX: 0, y: chatTableView.rowHeight/2)
            //            cell.alpha = 0
            //
            //            UIView.animate(withDuration: 0.5, delay: 0.01*Double(indexPath.row), options: [.curveEaseInOut], animations: {
            //                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            //                cell.alpha = 1
            //
            //            }, completion: nil)
            
            // animasi untuk bounce up di last index
            
            let startFromHeight = tableView.frame.height
            cell.layer.transform = CATransform3DMakeTranslation(0, startFromHeight, 0)
            let delay = Double(indexPath.row) * 0.01
            
            UIView.animate(withDuration: 0.5, delay: delay, options: UIView.AnimationOptions.transitionFlipFromBottom, animations: {
                do {
                    cell.layer.transform = CATransform3DIdentity
                }
            }) { (success:Bool) in
                
            }
            
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataMessage = newMessageArray[indexPath.row]
        UIView.animate(withDuration: 0.5) {
            self.chatMessage.text = dataMessage.messageFromMe
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func configureTableView() {
        chatTableView.rowHeight = UITableViewAutomaticDimension
        chatTableView.estimatedRowHeight = 400.0
        
    }
    
    
    @IBAction func done(_ sender: UITextField) {
        print("hit")
        chatMessage.endEditing(true)
        if chatMessage.text != "" {
            chatInput(newMessage: chatMessage.text!)
            
            getResponChat(newMessage: chatMessage.text!)
            chatMessage.text = ""
            
        }
    }
    
    
    
    @IBAction func sendPressed(_ sender: Any) {
        chatMessage.endEditing(true)
        if chatMessage.text != "" {
            chatInput(newMessage: chatMessage.text!)
            
            getResponChat(newMessage: chatMessage.text!)
            chatMessage.text = ""
        }
        
    }
    
    @IBAction func pressButtonMic(_ sender: Any) {
        
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
//            mic.isEnabled = false
            timer.invalidate()
            mic.setImage(#imageLiteral(resourceName: "icon_mic"), for: .normal)
            
        } else {
            startRecording()
            mic.setImage(#imageLiteral(resourceName: "icon_mic2"), for: .normal)
            
        }
        
    }
    
    func performZoom(startingImageView: UIImageView) {
        print("zoom...")
    }
    
    
    func chatInput(newMessage : String) {
        let messageRespon = Message()
        let messageLoading = MessageLoading()
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        messageRespon.type = "chatInput"
        
        messageRespon.messageFromMe = newMessage
        let time = formatter.string(from: date)
        
        let timeFix = formatter.date(from: time)
        formatter.dateFormat = "HH:mm"
        
        messageRespon.time = formatter.string(from: timeFix!)
        newMessageArray.append(messageRespon)
        configureTableView()
        chatTableView.reloadData()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.1, execute: {
            let indexPath = IndexPath(row: self.newMessageArray.count-1, section: 0)
            self.chatTableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.bottom, animated: true)
        })
        
    }
    
    func sendEmail(email : String, cc : String, subject : String, message : String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([email])
            mail.setSubject(subject)
            mail.setCcRecipients([cc])
            mail.setMessageBody("<p>\(message)</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            //            customAlert(title: "error", message: "Failed to send email")
            let alertVC = alertService.alert(title: "Perhatian !", message: "Gagal mengirim email", image: "ic_alert_warning", headerColor: "#FF9900", id: 0){
                //no action
            }
            present(alertVC, animated: true)
        }
    }
    
    func sendSMS(recipient : String, text : String) {
        if MFMessageComposeViewController.canSendText() {
            let message = MFMessageComposeViewController()
            message.messageComposeDelegate = self
            message.recipients = [recipient]
            message.body = text
            
            present(message, animated: true)
        } else {
            //            customAlert(title: "error", message: "Failed to send sms")
            let alertVC = alertService.alert(title: "Perhatian !", message: "Gagal mengirim email", image: "ic_alert_warning", headerColor: "#FF9900", id: 0){
                //no action
            }
            present(alertVC, animated: true)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func call(number : String) {
        
        if let url = URL(string: "tel://\(number)"),
            UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            //            customAlert(title: "error", message: "Failed to send call")
            let alertVC = alertService.alert(title: "Perhatian !", message: "Gagal melakukan panggilan", image: "ic_alert_warning", headerColor: "#FF9900", id: 0){
                //no action
            }
            present(alertVC, animated: true)
        }
    }
    
    func openApp(app : String) {
        
        if let url = URL(string: app),
            UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            //            customAlert(title: "error", message: "Failed to open \(app)")
            let alertVC = alertService.alert(title: "Perhatian !", message: "Gagal membuka aplikasi \(app)", image: "ic_alert_warning", headerColor: "#FF9900", id: 0){
                //no action
            }
            present(alertVC, animated: true)
        }
        
    }
    
    func reminderNotification(reminderTitle : String, reminderDate : String, reminderTime : String) {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = reminderTitle
        content.sound = UNNotificationSound.default()
        
        var dateComponents = DateComponents()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss"
        
        let dateFormatterYear = DateFormatter()
        dateFormatterYear.dateFormat = "yyyy"
        
        let dateFormatterMonth = DateFormatter()
        dateFormatterMonth.dateFormat = "MM"
        
        let dateFormatterDay = DateFormatter()
        dateFormatterDay.dateFormat = "dd"
        
        let dateFormatterHour = DateFormatter()
        dateFormatterHour.dateFormat = "HH"
        
        let dateFormatterMinutes = DateFormatter()
        dateFormatterMinutes.dateFormat = "HH"
        
        let dateFormatterSecond = DateFormatter()
        dateFormatterSecond.dateFormat = "HH"
        
        
        let dateFix = dateFormatter.date(from: reminderDate)!
        let timeFix = timeFormatter.date(from: reminderTime)!
        
        let yearFix = dateFormatterYear.string(from: dateFix)
        let monthFix = dateFormatterMonth.string(from: dateFix)
        let dayFix = dateFormatterDay.string(from: dateFix)
        let hourFix = dateFormatterHour.string(from: timeFix)
        let minuteFix = dateFormatterMinutes.string(from: timeFix)
        let secondFix = dateFormatterSecond.string(from: timeFix)
        
        dateComponents.year = Int(yearFix)
        dateComponents.month = Int(monthFix)
        dateComponents.day = Int(dayFix)
        dateComponents.hour = Int(hourFix)
        dateComponents.minute = Int(minuteFix)
        dateComponents.second = Int(secondFix)
        //        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: false)
        
        print(dateComponents)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    func scheduleNotification(titleAlarm : String, bodyAlarm : String, hour : Int, minutes : Int) {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = titleAlarm
        content.body =  bodyAlarm
        content.badge = 1
        content.sound = UNNotificationSound.default()
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minutes
        //        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: false)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    func getResponChat(newMessage : String) {
        
        loadingChat()
        var userId = ""
        var token = ""
        
        if let user_id = UserDefaults.standard.value(forKey: Constan.ID) as? String {
            userId = user_id
        }
        if let tokenUser =  UserDefaults.standard.value(forKey: Constan.TOKEN) as? String {
            token = tokenUser
        }
        
        let chatParams : [String : Any] = [
            "user_id" : En.encrypt(value: userId, key: Constan.WEBHOOK_KEY) ,
            "query" : En.encrypt(value: newMessage, key: Constan.WEBHOOK_KEY),
            "lat" : En.encrypt(value: lat, key: Constan.WEBHOOK_KEY),
            "lon" : En.encrypt(value: long, key: Constan.WEBHOOK_KEY),
            "channel" : En.encrypt(value: "ios", key: Constan.WEBHOOK_KEY),
        ]
        
        let header : HTTPHeaders = [
            "Content-Type":"application/json",
            "Accept": "application/json",
            "Authorization": "Bearer \(token)"
        ]
        print("chatParams ",chatParams)
        print("header ",header)
        print("url ",base_url)
       
        
        
        Alamofire.request("https://app.lenna.ai/app/public/api/\(Constan.BOT_ID)/webhook/mobile", method: .post, parameters: chatParams, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            print("respon chat ", "ada")
            
            if response.value != nil {
                let rs : JSON = JSON(response.value!)
                if rs["success"] == true {
                    //handle load
                    let count_message = self.newMessageArray.count
                    var last_data : Int  = 0
                    if self.newMessageArray.isEmpty == false{
                        last_data = self.newMessageArray.count
                        self.newMessageArray.remove(at: self.newMessageArray.count-1)
                    }
                    print("count_message",count_message)
                    print("count_message2",last_data)
                    
                    let dataPlain = self.Dc.decryp(value: rs["encryption"].stringValue, key: Constan.WEBHOOK_KEY)
                    let responChat = JSON.init(parseJSON: dataPlain)
                    
                    print("respon chat success ", "ada")
                    
                    let responOutput : JSON = responChat["result"]["output"]
                    let responQuickButton : JSON = responChat["result"]
                    
                    switch response.result {
                        
                    case .success :
                        
                        do {
                            
                            self.arrQuickButton = try JSONDecoder().decode(DataQuickButton.self, from: responQuickButton.rawData())
                            self.quickButtonCollection.reloadData()
                            
                            
                            for (_, subJson):(String, JSON) in responOutput {
                                
                                let newMessage = Message()
                                
                                let date = Date()
                                let formatter = DateFormatter()
                                formatter.dateFormat = "HH:mm"
                                
                                let time = formatter.string(from: date)
                                
                                let timeFix = formatter.date(from: time)
                                formatter.dateFormat = "HH:mm"
                                
                                newMessage.type = subJson["type"].stringValue
                                newMessage.subType = subJson["subType"].stringValue
                                newMessage.time = formatter.string(from: timeFix!)
                                
                                if newMessage.type == "text" {
                                    let stopWords = [Constan.KEY_FALLBACK]
                                    let stopWordsSet = Set(stopWords)
                                    let msg_text = subJson["text"].stringValue
                                    let msg_text_callback = msg_text.components(separatedBy: " ").first
                                    let msg_clear_text = msg_text
                                        .components(separatedBy: " ")
                                        .map { stopWordsSet.contains($0) ? "" : $0 }
                                        .joined(separator: " ")
                                    newMessage.messageText = msg_clear_text
                                    //                                    newMessage.messageText = self.handleFallback(value : subJson["text"].stringValue)
                                    if msg_text_callback == Constan.KEY_FALLBACK{
                                        self.isFalback = true
                                    }else{
                                        self.isFalback = false
                                    }
                                    
                                    
                                }
                                if newMessage.type == "html" {
                                    
                                    newMessage.messageHtml = try JSONDecoder().decode([OutputHtml].self, from: responOutput.rawData())
                                    
                                }
                                if newMessage.type == "image" {
                                    newMessage.originalContentUrl = subJson["originalContentUrl"].stringValue
                                }
                                if newMessage.type == "carousel" {
                                    newMessage.messageCarousel = try JSONDecoder().decode([OutputCarousel].self, from: responOutput.rawData())
                                    print("data Carousel ", newMessage.messageCarousel)
                                }
                                
                                if newMessage.type == "list" {
                                    newMessage.messageList = try JSONDecoder().decode([OutputList].self, from: responOutput.rawData())
                                    print("data list ", newMessage.messageList)
                                }
                                
                                if newMessage.type == "movie" {
                                    newMessage.messageMovieCarousel = try JSONDecoder().decode([OutputMovieCarousel].self, from: responOutput.rawData())
                                }
                                
                                if newMessage.type == "confirm" {
                                    newMessage.messageConfirm = try JSONDecoder().decode([OutputConfirm].self, from: responOutput.rawData())
                                    
                                    newMessage.confirmHasShow = true
                                }
                                
                                if newMessage.type == "form" {
                                    newMessage.messageForm = try JSONDecoder().decode([OutputForm].self, from: responOutput.rawData())
                                    newMessage.formHasShow = true
                                }
                                
                                if newMessage.type == "grid" {
                                    newMessage.messageGrid = try JSONDecoder().decode([OutputGrid].self, from: responOutput.rawData())
                                }
                                
                                if newMessage.type == "summary" {
                                    newMessage.messageSummary = try JSONDecoder().decode([OutputSummary].self, from: responOutput.rawData())
                                    print("data summary ", newMessage.messageSummary)
                                }
                                
                                if newMessage.type == "ticketList" {
                                    newMessage.messageAirplane = try JSONDecoder().decode([OutputAirplane].self, from: responOutput.rawData())
                                }
                                
                                
                                if newMessage.type == "weather" {
                                    newMessage.messageWeather = try JSONDecoder().decode([OutputWeather].self, from: responOutput.rawData())
                                }
                                
                                if newMessage.type == "action" {
                                    if newMessage.subType == "composeMail" {
                                        newMessage.messageComposeEmail = try JSONDecoder().decode(DataComposeEmail.self, from: responOutput[0]["data"].rawData())
                                        
                                        newMessage.emailHasShow = true
                                    }
                                    if newMessage.subType == "composeSMS" {
                                        newMessage.messageComposeSMS = try JSONDecoder().decode(DataComposeSMS.self, from: responOutput[0]["data"].rawData())
                                        
                                        newMessage.smsHasShow = true
                                    }
                                    if newMessage.subType == "makeCall" {
                                        newMessage.messageComposeCall = try JSONDecoder().decode(DataComposeCall.self, from: responOutput[0]["data"].rawData())
                                        
                                        newMessage.callHasShow = true
                                    }
                                    if newMessage.subType == "openApp" {
                                        newMessage.messageOpenApp = try JSONDecoder().decode(DataOpenApp.self, from: responOutput[1]["data"].rawData())
                                        
                                        newMessage.openAppHasShow = true
                                    }
                                    if newMessage.subType == "setAlarm" {
                                        newMessage.messageSchedule = try JSONDecoder().decode(DataSchedule.self, from: responOutput[0]["data"].rawData())
                                        
                                        newMessage.scheduleHasShow = true
                                    }
                                    if newMessage.subType == "setSchedule" {
                                        newMessage.messageReminder = try JSONDecoder().decode(DataReminder.self, from: responOutput[0]["data"].rawData())
                                        
                                        newMessage.reminderHasShow = true
                                    }
                                    
                                }
                                
                               
                                self.newMessageArray.append(newMessage)
                                
                                let utterance = responOutput[0]["text"].stringValue + responOutput[1]["text"].stringValue
                                
                                self.customVoice(text: self.handleVoiceFallback(value: utterance))
                                
                                
                                self.configureTableView()
                                self.chatTableView.reloadData()
                                
                                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.1, execute: {
                                    let indexPath = IndexPath(row: self.newMessageArray.count-1, section: 0)
                                    self.chatTableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.bottom, animated: true)
                                })
                                if (self.isFalback == true) {
                                    self.isFalback = false
                                    self.getResponChat(newMessage: Constan.REQUEST_MENU_FALLBACK)
                                }
                                
                            }
                            
                            
                        }catch {
                            //                        self.newMessageArray.remove(at: self.newMessageArray.count-1)
                            print(error)
                            //                        let loading = Message()
                            //                        loading.type = "text"
                            //                        loading.messageText = "Maaf sepertinya terjadi kesalahan"
                            //                        self.newMessageArray.append(loading)
                            self.chatTableView.reloadData()
                            
                        }
                        
                    case .failure(let error):
                        //                    self.newMessageArray.remove(at: self.newMessageArray.count-1)
                        print(error)
                        //                    let loading = Message()
                        //                    loading.type = "text"
                        //                    loading.messageText = "Maaf sedang ada masalah koneksi nih , coba lagi ya"
                        //                    self.newMessageArray.append(loading)
                        self.chatTableView.reloadData()
                        
                    }
                }
                
                
            }
            
        }
        
    }
    
    func customVoice(text: String)
    {
        let url = "https://bcc.bni.sdtech.co.id/api/general/getvoiceurl"
        let params : [String : Any] = [
            "platform": "ios",
        ]

        Alamofire.request(url, method: .post, parameters: params,encoding: JSONEncoding.default)
            .responseJSON {
                response in
                print("resonse voice -> ",response)
                
                if response.result.isSuccess {
                    let responseJSON : JSON = JSON(response.result.value!)
                    print("resonse voice 2 -> ",responseJSON)
                    
                    let femaleVoice = responseJSON["female"].stringValue
                    
                    let escapedString = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                    
                    let textSpeak = femaleVoice.replacingOccurrences(of: "$paramtext", with: escapedString!)
                    print("resonse voice 3-> ",escapedString as Any)
                    
                    let url = NSURL(string: textSpeak)
                    // add
                    let audioSession = AVAudioSession.sharedInstance()
                    do {
                        try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
                    } catch let error as NSError {
                        print("resonse voice xx setCategory error: \(error.localizedDescription)")
                    }
                    
                    do {
                        print("resonse voice 4-> ,ini adalah text voice : ", text)
                        let playerItem = AVPlayerItem(url: url! as URL)
                        try audioSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
                        self.player = AVPlayer(playerItem:playerItem)
                        self.player!.volume = 3.0
                        self.player!.play()
                    } catch let error as NSError {
                        self.player = nil
                        print("resonse voice 5-> ",error.localizedDescription)
                    } catch {
                        print("resonse voice 6-> ,AVAudioPlayer init failed")
                    }
                    
                }
                else {
                    print("resonse voice error-> ","response else")
                    let alertVC = self.alertService.alert(title: "Perhatian !", message: "Maaf, terjadi kesalahan silahkan coba beberapa saat lagi", image: "ic_alert_warning", headerColor: "#FF9900", id: 0){
                        // no action
                    }

                    self.present(alertVC, animated: true)
                    
                }
        }
    }
    
    
    func customAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showNavItem(){
        
        let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "fill_1")
        imageView.image = image
        logoContainer.addSubview(imageView)
        
        navigationItem.titleView = logoContainer
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        
    }
    
    
}


let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImageUsingCache(imageUrl: String) {
        
        if let chacheImage = imageCache.object(forKey: imageUrl as AnyObject) as? UIImage {
            self.image = chacheImage
            return
        }
        
        let url = NSURL(string: imageUrl)
        URLSession.shared.dataTask(with: url! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error as Any)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                if let downloadImage = UIImage(data: data!) {
                    imageCache.setObject(downloadImage, forKey: imageUrl as AnyObject)
                    
                    self.image = downloadImage
                }
            })
            
        }).resume()
    }
    
}



extension ChatViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if arrQuickButton == nil {
            self.quickButtonCollection.alpha = 0
            return 1
        }else {
            if self.arrQuickButton.quickbutton != nil {
                self.quickButtonCollection.alpha = 1
                return arrQuickButton.quickbutton.count
            }else {
                self.quickButtonCollection.alpha = 0
                return 1
            }
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : QuickButtonCell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuickButtonCell", for: indexPath) as! QuickButtonCell
        
        if arrQuickButton == nil {
            cell.quickButton.setTitle("option1", for: .normal)
        }
        else {
            if arrQuickButton.quickbutton != nil {
                cell.quickButton.setTitle(arrQuickButton.quickbutton[indexPath.item], for: .normal)
                cell.quickButton.addTarget(self, action: #selector(quickBtnTapped), for: .touchUpInside)
                cell.quickButton.tag = indexPath.row
                
                // in swift 5
                cell.layer.borderWidth = 1
                cell.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                cell.layer.cornerRadius = 20
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.1, execute: {
                    let indexPath = IndexPath(row: self.newMessageArray.count-1, section: 0)
                    self.chatTableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.bottom, animated: true)
                })
                
            }else {
                cell.quickButton.setTitle("option1", for: .normal)
            }
        }
        
        return cell
    }
    
    @objc func quickBtnTapped (sender : UIButton) {
        self.quickButtonCollection.alpha = 0
        chatInput(newMessage: arrQuickButton.quickbutton[sender.tag])
        getResponChat(newMessage: arrQuickButton.quickbutton[sender.tag])
    }
    
    func requestTranscribePermissions() {
        SFSpeechRecognizer.requestAuthorization { [unowned self] authStatus in
            DispatchQueue.main.async {
                if authStatus == .authorized {
                    print("SFSpeechRecognizer ok")
                } else {
                    print("Transcription permission was declined.")
                    self.handlePermissionFailed()
                }
            }
        }
    }
    
    private func handlePermissionFailed() {
        // Present an alert asking the user to change their settings.
        let ac = UIAlertController(title: "This app must have access to speech recognition to work.",
                                   message: "Please consider updating your settings.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Open settings", style: .default) { _ in
            let url = URL(string: UIApplicationOpenSettingsURLString)!
            UIApplication.shared.open(url)
        })
        ac.addAction(UIAlertAction(title: "Close", style: .cancel))
        present(ac, animated: true)
        
        
        // Disable the record button.
        // recordButton.isEnabled = false
        // recordButton.setTitle("Speech recognition not available.", for: .normal)
        
    }
    
    private func handleError(withMessage message: String) {
        // Present an alert.
        let ac = UIAlertController(title: "An error occured", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        
        // Disable record button.
        // recordButton.setTitle("Not available.", for: .normal)
        // recordButton.isEnabled = false
    }
    
    func startRecording() {
        
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        //
        micActive = true
        if self.player != nil && self.player.rate != 0{
            self.player!.pause()
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, mode: AVAudioSessionModeDefault)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode = audioEngine.inputNode
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            print("startRecording result",result)
            print("startRecording error", error)

            
            var isFinal = false
            
            if result != nil {
                
                isFinal = (result?.isFinal)!
                print("startRecording isfinal", isFinal)

            }
            
            if error != nil || isFinal {
                print("startRecording error != nil || isFinal")
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.mic.isEnabled = true
            }else if error == nil {
                print("startRecording error 2", error)
                self.restartSpeechTimer(chat: result!.bestTranscription.formattedString)
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        
        //        nickName.text = "listening..."
        
    }
    
    func restartSpeechTimer(chat: String) {
        
        timer.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { (timer) in
            // Do whatever needs to be done when the timer expires
            print("interval stop....")
            let a =  chat.replacingOccurrences(of: "(", with: "")
            let b =  a.replacingOccurrences(of: ")", with: "")
            self.chatMessage.text = b
            print(chat)
            self.recognitionTask?.cancel()
            self.audioEngine.stop()
            self.mic.setImage(UIImage(named: "icon_mic"), for: .normal)
            self.micActive = false
            if self.player != nil && self.player.rate != 0{
                self.player!.pause()
            }
            self.sendToChat(text: b)
        })
        
    }
    
    private func sendToChat(text : String){
        timer2.invalidate()
        timer2 = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { (timer) in
            // Do whatever needs to be done when the timer expires
            if  self.chatMessage.text != "" {
                self.chatInput(newMessage: self.chatMessage.text!)
                self.getResponChat(newMessage: self.chatMessage.text!)
                self.chatMessage.text = ""
            }
        })
        
    }
    
    private func setLogoHeader(){
        self.logoHeader.image = UIImage(named: Constan.LOGO_TITLE)
    }
    
    func handleFallback(value : String) -> String{
        let stopWords = [Constan.KEY_FALLBACK]
        let stopWordsSet = Set(stopWords)
        let msg_text = value
        let msg_text_callback = msg_text.components(separatedBy: " ").first
        let msg_clear_text = msg_text
            .components(separatedBy: " ")
            .map { stopWordsSet.contains($0) ? "" : $0 }
            .joined(separator: " ")
        
        if msg_text_callback == Constan.KEY_FALLBACK{
//            getResponChat(newMessage: Constan.REQUEST_MENU_FALLBACK)
            return msg_clear_text
        }else{
            return value
        }
        
    }
    
    func handleVoiceFallback(value : String) -> String {
        let stopWords = [Constan.KEY_FALLBACK]
        let stopWordsSet = Set(stopWords)
        let msg_text = value
        let msg_text_callback = msg_text.components(separatedBy: " ").first
        let msg_clear_text = msg_text
            .components(separatedBy: " ")
            .map { stopWordsSet.contains($0) ? "" : $0 }
            .joined(separator: " ")
        
        if msg_text_callback == Constan.KEY_FALLBACK{
            return msg_clear_text
        }else{
            return value
        }
        
    }
    public func firstChat (){
        var token = ""
        if let tokenUser =  UserDefaults.standard.value(forKey: Constan.TOKEN) as? String {
            token = tokenUser
        }
        
        if token == "" {
            // Do whatever needs to be done when the timer expires
            //            self.getResponChat(newMessage: Constan.GREETING_MESSAGE)
        }else{
            self.getResponChat(newMessage: Constan.GREETING_MESSAGE)
        }
        
    }
    
    func loadingChat(){
        let nMessage = Message()
        nMessage.type = "loading"
        newMessageArray.append(nMessage)
        
        configureTableView()
        chatTableView.reloadData()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.1, execute: {
            let indexPath = IndexPath(row: self.newMessageArray.count-1, section: 0)
            self.chatTableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.bottom, animated: true)
        })
        
    }
    
    
}

