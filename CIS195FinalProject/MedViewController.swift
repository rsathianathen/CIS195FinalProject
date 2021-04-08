//
//  MedViewController.swift
//  CIS195FinalProject
//
//  Created by Ryan Sathianathen on 4/2/21.
//

import UIKit

class MedViewController: UIViewController {
    
   
    var medName:String = ""
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = medName
        self.navigationController?.navigationBar.tintColor = UIColor.purple
        navigationItem.rightBarButtonItem?.tintColor = UIColor.purple

        
    }
}
