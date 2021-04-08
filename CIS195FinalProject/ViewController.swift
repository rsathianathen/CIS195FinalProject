//
//  ViewController.swift
//  CIS195FinalProject
//
//  Created by Ryan Sathianathen on 4/2/21.
//

import UIKit

class ViewController: UITableViewController, AddProfileDelegate {
    
    var savedProfile: Profile?
    let medicationsList = ["Aspirin", "Acetaminophen", "Imatinib", "Dasatanib"]
    
    func didCreate(_ profile: Profile) {
        dismiss(animated: true, completion: nil)
        savedProfile = profile
        self.tableView.reloadData()
    }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = "Medications"
        navigationItem.rightBarButtonItem?.tintColor = UIColor.purple
        navigationItem.leftBarButtonItem?.tintColor = UIColor.purple
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

        return medicationsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "specificMedication")
        if let medication = cell?.viewWithTag(1) as? UILabel {
            let medName = medicationsList[indexPath.row]
            medication.text = medName
        }
            return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier:"medication", sender: self)
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "profile" {
            if let vc = segue.destination as? ProfileController {
                vc.Name = savedProfile?.Name ?? ""
                vc.EmailAddress = savedProfile?.emailAddress ?? ""
                vc.Age = savedProfile?.age ?? ""
                vc.PhoneNumber = savedProfile?.phoneNumber ?? ""
                vc.Gender = savedProfile?.gender ?? ""
                vc.delegate = self
            }
        }
        
        if segue.identifier == "medication" {
            if let mc = segue.destination as? MedViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    let selectedRow = indexPath.row
                    mc.medName = medicationsList[selectedRow]
                }
                
            }
        }
        
        if segue.identifier == "addMedication" {
            if let navAc = segue.destination as? UINavigationController {
                if let ac = navAc.topViewController as? AddMedicationController {
                    ac.medicationsList = medicationsList
                }
                
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 43.5
    }
    
    
}
