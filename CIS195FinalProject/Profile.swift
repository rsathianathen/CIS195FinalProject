//
//  Profile.swift
//  CIS195FinalProject
//
//  Created by Ryan Sathianathen on 4/2/21.
//

import UIKit
struct Profile {
    
    var Name: String
    var emailAddress: String
    var phoneNumber: String
    var age: String
    
    init (name: String, email: String, number: String, age: String) {

        self.Name = name
        self.emailAddress = email
        self.phoneNumber = number
        self.age = age
    }
}
