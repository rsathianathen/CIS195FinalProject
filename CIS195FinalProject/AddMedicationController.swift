//
//  AddMedicationController.swift
//  CIS195FinalProject
//
//  Created by Ryan Sathianathen on 4/8/21.
//

import UIKit

class AddMedicationController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var medications: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var medicationsList: [String] = []
    var searching = false
    var filteredResults = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        medications.delegate = self
        medications.dataSource = self
        navigationItem.leftBarButtonItem?.tintColor = UIColor.purple
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var currentResults = [String]()
        for med in medicationsList {
            print (searchBar.text!)
            if med.lowercased().contains(searchBar.text!.lowercased()){
                currentResults.append(med)
            }
        }
        
        filteredResults = currentResults
        searching = true
        self.medications.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            self.searching = false
            self.medications.reloadData()
        } else {
            var currentResults = [String]()
            for med in medicationsList {
                print (searchBar.text!)
                if med.lowercased().contains(searchBar.text!.lowercased()){
                    currentResults.append(med)
                }
            }
            
            filteredResults = currentResults
            searching = true
            self.medications.reloadData()
        }
        
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text == "" {
            self.searching = false
            self.medications.reloadData()
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text == "" {
            self.searching = false
            self.medications.reloadData()
        }
    }
    
    
    @IBAction func cancelling(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // TODO: How many sections? (Hint: we have 1 section and x rows)
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return filteredResults.count
        }
        return medicationsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchedMedication")
        if let medication = cell?.viewWithTag(1) as? UILabel {
            if searching {
                medication.text = filteredResults[indexPath.row]
            } else {
                medication.text = medicationsList[indexPath.row]
            }
            
           
        }
            return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 43.5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier:"medInfo", sender: self)
       
    }
}
