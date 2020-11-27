//
//  CustomGenderController.swift
//  Lenna
//
//  Created by Agustiar on 6/4/19.
//  Copyright © 2019 sdtech. All rights reserved.
//

import UIKit

protocol CustomGenderDelegate: AnyObject {
    func genderPickerValue(genderData: String)
}

class CustomGenderController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var genderHeaderView: UIView!
    @IBOutlet weak var pickerContainerView: UIView!
    
    let gender = ["Pria", "Wanita"]
    var buttonAction: (() -> Void)?
    var delegate: CustomGenderDelegate? = nil
    var getGender = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerContainerView.layer.cornerRadius = 10
        genderHeaderView.layer.cornerRadius = 10
        genderHeaderView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gender.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gender[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("UIPICKER VIEW :", gender[row])
        getGender = gender[row]
    }
    
    @IBAction func doneButton(_ sender: UIButton) {
        buttonAction?()
        self.delegate?.genderPickerValue(genderData: getGender)
        dismiss(animated: true)
    }
    
    
   

}
