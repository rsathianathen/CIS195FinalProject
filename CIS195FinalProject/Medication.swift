//
//  Medication.swift
//  CIS195FinalProject
//
//  Created by Ryan Sathianathen on 5/1/21.
//

import UIKit

struct Medication {
    
    var name: String
    var form: String
    var dose: String
    var sun: Bool
    var mon: Bool
    var tues: Bool
    var wed: Bool
    var thurs: Bool
    var fri: Bool
    var sat: Bool
    var morning: Bool
    var afternoon: Bool
    var evening: Bool
    var medNumber: Int
    
    init (names: String, forms: String, doses: String, suns: Bool, mons: Bool, tuess: Bool, weds: Bool, thurss: Bool, fris: Bool, sats: Bool, mornings: Bool, afternoons: Bool, evenings: Bool, number: Int){
        self.name = names
        self.form = forms
        self.dose = doses
        self.sun = suns
        self.mon = mons
        self.tues = tuess
        self.wed = weds
        self.thurs = thurss
        self.fri = fris
        self.sat = sats
        self.morning = mornings
        self.afternoon = afternoons
        self.evening = evenings
        self.medNumber = number
    }
}

