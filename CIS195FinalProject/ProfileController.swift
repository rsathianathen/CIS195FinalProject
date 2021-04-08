//
//  ProfileController.swift
//  CIS195FinalProject
//
//  Created by Ryan Sathianathen on 4/2/21.
//

import UIKit

protocol AddProfileDelegate: class {
    func didCreate(_ profile: Profile)
}

class ProfileController: UIViewController, UITextFieldDelegate {

    weak var delegate: AddProfileDelegate?
    
    private let ages = Array(0...99)
    private let genders = ["Select Gender", "Female", "Male", "Nonbinary"]
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var ageSelector: UIPickerView!
    @IBOutlet weak var numberAge: UILabel!
    @IBOutlet weak var genderSelector: UIPickerView!
    @IBOutlet weak var gender: UILabel!
    
    var Name = ""
    var EmailAddress = ""
    var PhoneNumber = ""
    var Age = ""
    var Gender = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Profile Info"
        self.navigationController?.navigationBar.tintColor = UIColor.purple
        navigationItem.rightBarButtonItem?.tintColor = UIColor.purple
        name.placeholder = "Name"
        emailAddress.placeholder = "Email Address"
        phoneNumber.placeholder = "Phone Number"
        name.delegate = self
        emailAddress.delegate = self
        phoneNumber.delegate = self
        name.text = Name
        phoneNumber.text = PhoneNumber
        emailAddress.text = EmailAddress
        
        if Age == "" {
            numberAge.text = "Select Age"
        } else {
            numberAge.text = Age
        }
        ageSelector.dataSource = self
        ageSelector.delegate = self
        genderSelector.dataSource = self
        genderSelector.delegate = self
        if Gender == "" {
            gender.text = "Select Gender"
        } else {
            gender.text = Gender
        }
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        name.resignFirstResponder()
        emailAddress.resignFirstResponder()
        phoneNumber.resignFirstResponder()
        return true
    }
    
    
    @IBAction func saveInfo(_ sender: Any) {
        if let updatedProfile = updateProfile() {
            self.delegate?.didCreate(updatedProfile)
        }
        
        
    }
    
    func updateProfile() -> Profile? {
        Name = name.text ?? ""
        EmailAddress = emailAddress.text ?? ""
        PhoneNumber = phoneNumber.text ?? ""
        Age = numberAge.text ?? ""
        Gender = gender.text ?? ""
        
        let updatedProfile: Profile? = Profile(name: Name,  email: EmailAddress, number: PhoneNumber, age: Age, gender: Gender)
        return updatedProfile
   
    }

}

extension ProfileController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 0){
            return genders.count
        } else {
            return ages.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView.tag == 0){
            gender.text = "Gender: " + String(genders[row])
        } else {
            numberAge.text = "Age: " + String(ages[row])
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 0){
           return String(genders[row])
        } else {
           return String(ages[row])
        }
    }
    
}
