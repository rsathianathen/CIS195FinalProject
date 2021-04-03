//
//  ViewController.swift
//  CIS195FinalProject
//
//  Created by Ryan Sathianathen on 4/2/21.
//

import UIKit

class ViewController: UITableViewController, AddProfileDelegate {
    
    func didCreate(_ profile: Profile) {
        dismiss(animated: true, completion: nil)
    }
    

        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = "Medications"
    }
    
   
    
    @IBAction func openProfile(_ sender: Any) {
        performSegue(withIdentifier: "profile", sender: self)
    }
    
    
    @IBAction func addMed(_ sender: Any) {
        performSegue(withIdentifier: "addMedication", sender: self)
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // TODO: How many sections? (Hint: we have 1 section and x rows)
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
            return  UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier:"medication", sender: self)
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "profile" {
            if let navVC = segue.destination as? UINavigationController{
                if let apVC = navVC.topViewController as? ProfileController {
                    apVC.delegate = self
                }
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
    
    
}
