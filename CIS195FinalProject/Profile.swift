//
//  Profile.swift
//  CIS195FinalProject
//
//  Created by Ryan Sathianathen on 4/2/21.
//

import UIKit
struct Profile {
    
    var profilePic: UIImage?
    var Name: String
    var emailAddress: String
    var phoneNumber: String
    var age: String
    
    init (picture: UIImage?, name: String, last: String,  email: String, number: String, age: String){
        self.profilePic = picture
        self.Name = name
        self.emailAddress = email
        self.phoneNumber = number
        self.age = age
    }
}
