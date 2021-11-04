//
//  UserDetailsTableViewController.swift
//  Json_Parse
//
//  Created by user on 10/5/21.
//

import UIKit


//secondary view
class PatientDetailsViewController: UITableViewController {

    @IBOutlet weak var familyNameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var birthDateLabel: UILabel!
    @IBOutlet weak var lastUpdatedLabel: UILabel!
    
    var patient: Patient? {
      didSet {
        refreshUI()
      }
    }
    
    private func refreshUI() {
        loadViewIfNeeded()
        
        familyNameLabel.text = patient?.familyName.capitalized
        genderLabel.text = patient?.gender.capitalized
        birthDateLabel.text = patient?.birthDate.capitalized
        lastUpdatedLabel.text = patient?.lastUpdated
    }
    
    //MARK: table view delegate
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsets.zero
    }
}


extension PatientDetailsViewController: PatientSelectionDelegate {
  func patientSelected(_ newPatient: Patient) {

      patient = newPatient
  }
}
