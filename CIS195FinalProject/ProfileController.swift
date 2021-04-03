//
//  ProfileController.swift
//  CIS195FinalProject
//
//  Created by Ryan Sathianathen on 4/2/21.
//

import UIKit

class ProfileController: UIViewController, UITextFieldDelegate {

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
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        age.resignFirstResponder()
        name.resignFirstResponder()
        emailAddress.resignFirstResponder()
        phoneNumber.resignFirstResponder()
        return true
    }
    
    

   
    
}
