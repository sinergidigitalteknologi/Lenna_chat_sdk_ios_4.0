//
//  CustomAlertService.swift
//  Lenna
//
//  Created by Agustiar on 5/14/19.
//  Copyright © 2019 sdtech. All rights reserved.
//

import UIKit


class CustomAlertService: CustomDateDelegate{
    
    func datePickerValue(dateData: String) {
        print("halo : ", dateData)
    }
    
    
    func alert(title: String, message: String,image: String, headerColor: String, id : Int, completion: @escaping () -> Void) -> CustomAlertController{
        let storyboard = UIStoryboard(name: "CustomAlert", bundle: .main)
        
        let alertVC = storyboard.instantiateViewController(withIdentifier: "customAlert") as! CustomAlertController
        
        alertVC.titleText = title
        alertVC.messageText = message
        alertVC.buttonAction = completion
        alertVC.alertHeader = headerColor
        alertVC.idAlert = id
        alertVC.imageIconName = image
        
        return alertVC
    }
    
    func confirmationAlert(title: String, message: String, headerColor: String, completion: @escaping () -> Void) -> ConfirmationCustomAlertController{
        let storyboard = UIStoryboard(name: "ConfirmationCustomAlert", bundle: .main)
        
        let confirmationAlertVC = storyboard.instantiateViewController(withIdentifier: "confirmationCustomAlert") as! ConfirmationCustomAlertController
        
        confirmationAlertVC.titleText = title
        confirmationAlertVC.messageText = message
        confirmationAlertVC.buttonAction = completion
        confirmationAlertVC.alertHeader = headerColor
        
        return confirmationAlertVC
    }
    
    func datePicker(controller: [Any], completion: @escaping () -> Void) -> CustomDatePickerController {
        
        let storyboard = UIStoryboard(name:"CustomDatePicker", bundle: .main)
        let datePickerVC = storyboard.instantiateViewController(withIdentifier: "customDatePicker") as! CustomDatePickerController
        
        let classArray: [UIViewController.Type] = [
            controller[0] as! UIViewController.Type
        ]
        let controllerClass = classArray[0]
        let controller = controllerClass.init()
        
        
        
        datePickerVC.buttonAction = completion //action inside pop up
        datePickerVC.delegate = controller as? CustomDateDelegate //controller name who want to use custom datepicker
        
        return datePickerVC
        
    }
    
    func genderPicker(controller: [Any], completion: @escaping () -> Void) -> CustomGenderController {
        
        let storyboard = UIStoryboard(name:"CustomGender", bundle: .main)
        let genderPickerVC = storyboard.instantiateViewController(withIdentifier: "customGender") as! CustomGenderController
        
        let classArray: [UIViewController.Type] = [
            controller[0] as! UIViewController.Type
        ]
        let controllerClass = classArray[0]
        let controller = controllerClass.init()
        
        genderPickerVC.buttonAction = completion //action inside pop up
        genderPickerVC.delegate = controller as? CustomGenderDelegate //controller name who want to use custom gender picker
        
        return genderPickerVC
        
    }
    
}
