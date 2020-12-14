//
//  CarouselViewCell.swift
//  Lenna
//
//  Created by MacBook Air on 2/25/19.
//  Copyright © 2019 sdtech. All rights reserved.
//

import UIKit
import MapKit

protocol CarouselButtonDelegate {
    func CarouselButton (newMessage: String)
}


class CarouselViewCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource,UICollectionViewDelegateFlowLayout
 {

//    @IBOutlet weak var carouselView: UICollectionViewCell!
    @IBOutlet weak var mainBg: UIView!
    @IBOutlet weak var imageArrayCarousel: UIImageView!
    @IBOutlet weak var btnList: UITableView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var buttonHeight: NSLayoutConstraint!
    @IBOutlet weak var marginTop: NSLayoutConstraint!
    
    
    var userInterfaceStyle : UIUserInterfaceStyle?
    
    var arrAction = [ActionCarousel]()
    
    var btnDelegate : CarouselButtonDelegate?
    
    var dataButton : String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        btnList.delegate = self
        btnList.dataSource = self
        
      
        
        btnList.register(UINib(nibName: "ButtonCarousel", bundle: nil), forCellReuseIdentifier: "ButtonCarousel")
        
        btnList.estimatedRowHeight = 25.0
        
        if self.traitCollection.userInterfaceStyle == .dark {
            // User Interface is Dark
            if #available(iOS 13.0, *) {
                self.mainBg.backgroundColor = .secondarySystemBackground
                self.title.textColor = .white
                self.subTitle.textColor = .white
                self.title.backgroundColor = .secondarySystemBackground
                layer.cornerRadius = 12
                contentView.layer.cornerRadius = 12
                contentView.layer.masksToBounds = false
                layer.masksToBounds = false

                
                layer.backgroundColor = UIColor.secondarySystemBackground.cgColor


            } else {
           
                self.mainBg.backgroundColor = .white
                self.title.textColor = .darkGray
                self.title.backgroundColor = .white
                layer.cornerRadius = 12
                
                contentView.layer.cornerRadius = 12
                contentView.layer.masksToBounds = false
                
                layer.backgroundColor = UIColor.white.cgColor

            }
            layer.borderWidth = 0
            print("dark mode")
        }else {
            print("CarouselViewCell awakeFromNib light mode")

            self.mainBg.backgroundColor = .white

            self.title.textColor = .darkGray
            self.subTitle.textColor = .darkGray

            self.title.backgroundColor = .white
            layer.cornerRadius = 12
            contentView.layer.cornerRadius = 12
            contentView.layer.borderWidth = 0.7
            contentView.layer.borderColor = UIColor.clear.cgColor
            contentView.layer.masksToBounds = false
            
            layer.shadowColor = UIColor.lightGray.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 0.05)
            layer.shadowRadius = 3
            layer.shadowOpacity = 0.7
            layer.masksToBounds = false
//            layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
            layer.backgroundColor = UIColor.white.cgColor

        }
        //set on line false
        subTitle.numberOfLines = 0
         //   subTitle.lineBreakMode = .byTruncatingTail
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        //set on line false
            subTitle.adjustsFontSizeToFitWidth = false
            subTitle.lineBreakMode = .byTruncatingTail
        
        let userInterfaceStyle1 = traitCollection.userInterfaceStyle // Either .unspecified, .light, or .dark
        // Update your user interface based on the appearance
        
        if #available(iOS 13.0, *) {
            
            if userInterfaceStyle1 == .dark {
                self.mainBg.backgroundColor = .secondarySystemBackground
                self.title.textColor = .white
                self.title.backgroundColor = .secondarySystemBackground
                layer.cornerRadius = 12
                print("dark mode")
                
                contentView.layer.cornerRadius = 12
                contentView.layer.masksToBounds = false
                
              
                layer.backgroundColor = UIColor.secondarySystemBackground.cgColor

                
            } else {
                print("CarouselViewCell traitCollectionDidChange light mode")
                self.mainBg.backgroundColor = .white
                self.title.textColor = .darkGray
                self.title.backgroundColor = .white
                layer.cornerRadius = 12
                
                contentView.layer.cornerRadius = 12
                contentView.layer.borderWidth = 0.7
                contentView.layer.borderColor = UIColor.clear.cgColor
                contentView.layer.masksToBounds = false
                
                layer.shadowColor = UIColor.lightGray.cgColor
                layer.shadowOffset = CGSize(width: 0, height: 0.15)
                layer.shadowRadius = 3
                layer.shadowOpacity = 0.7
                layer.masksToBounds = false
//                layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
                layer.backgroundColor = UIColor.white.cgColor

            }
            
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrAction.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : ButtonCarousel! = tableView.dequeueReusableCell( withIdentifier: "ButtonCarousel") as? ButtonCarousel
        
        cell.btnAction.setTitle(arrAction[indexPath.item].label, for: .normal)
        
        cell.btnAction.addTarget(self, action: #selector(buttonSelected), for: .touchUpInside)
        
        cell.btnAction.tag = indexPath.row
        
        if arrAction[indexPath.item].data != nil {
            dataButton = arrAction[indexPath.row].data
        }
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("CarouselViewCell tableView size",self.btnList.contentSize.height)
        
//        if arrAction.count == 1 {
//            marginTop.constant = self.btnList.contentSize.height
//        }
    }
    
    @objc func buttonSelected(sender: UIButton){
        print(sender.tag)
        print(dataButton)
        
        if arrAction[sender.tag].type == "postback" {
            btnDelegate?.CarouselButton(newMessage: arrAction[sender.tag].data)
        }else if arrAction[sender.tag].type == "uri"{
            if let url = URL(string: arrAction[sender.tag].uri) {
                UIApplication.shared.open(url)
            }
        }else {
            let dataLocation = arrAction[sender.tag].data
            let arrDataLocation = dataLocation!.components(separatedBy: ",")
            
            print(arrDataLocation[0])
            print(arrDataLocation[1])
            
            var placeName = "no name"
            
            if let name = arrDataLocation[2] as String? {
                placeName = name
            }
            
            
            openMapForPlace(latitude: Double(arrDataLocation[0])!, longitude: Double(arrDataLocation[1])!, name: placeName)
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 10, height: 10)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func openMapForPlace(latitude : Double, longitude : Double, name : String) {
        
//        let latitude: CLLocationDegrees = -6.271890
//        let longitude: CLLocationDegrees = 106.764008
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = name
        mapItem.openInMaps(launchOptions: options)
    }


}
