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
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var age: UITextField!
    
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
        age.placeholder = "Age"
        name.delegate = self
        emailAddress.delegate = self
        phoneNumber.delegate = self
        age.delegate = self
        name.text = Name
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        age.resignFirstResponder()
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
        Age = age.text ?? ""
        
        let updatedProfile: Profile? = Profile(name: Name,  email: EmailAddress, number: PhoneNumber, age: Age)
        return updatedProfile
   
    }
    
    
    
    

   
    
}
