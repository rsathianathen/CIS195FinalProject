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
    
    private let ages = Array(16...99)
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var ageSelector: UIPickerView!
    @IBOutlet weak var numberAge: UILabel!
    
    var Name = ""
    var EmailAddress = ""
    var PhoneNumber = ""
    var Age = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Medications"
        name.placeholder = "Name"
        emailAddress.placeholder = "Email Address"
        phoneNumber.placeholder = "Phone Number"
        name.delegate = self
        emailAddress.delegate = self
        phoneNumber.delegate = self
        name.text = Name
        if Age == "" {
            numberAge.text = "Select Age"
        } else {
            numberAge.text = Age
        }
        ageSelector.dataSource = self
        ageSelector.delegate = self
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
        
        let updatedProfile: Profile? = Profile(name: Name,  email: EmailAddress, number: PhoneNumber, age: Age)
        return updatedProfile
   
    }

}

extension ProfileController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        numberAge.text = "Age: " + String(ages[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String (ages[row])
    }
    
}
