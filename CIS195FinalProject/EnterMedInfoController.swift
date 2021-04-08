//
//  EnterMedInfoController.swift
//  CIS195FinalProject
//
//  Created by Ryan Sathianathen on 4/8/21.
//

import UIKit

class EnterMedInfoController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem?.tintColor = UIColor.purple
        navigationItem.leftBarButtonItem?.tintColor = UIColor.purple
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveNewMed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        //needs to be fixed with delegate
    }
}
