//
//  ViewController.swift
//  Json_Parse
//
//  Created by user on 10/5/21.
//

import UIKit

protocol PatientSelectionDelegate: AnyObject {
    func patientSelected(_ newPatient: Patient)
}

//primary view
class PatientListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    weak var delegate: PatientSelectionDelegate?
    var patients = [Patient]()
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Lifecycle
    override func viewDidLoad(){
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        getPatients()
    }
    
    
    // MARK: Table view data source, table view delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let label = cell.viewWithTag(1) as! UILabel
        label.text = patients[indexPath.row].givenName.capitalized
        
        self.tableView.sizeToFit()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPatient = patients[indexPath.row]
        delegate?.patientSelected(selectedPatient)
        
        //when screen's width is not big enough to show two view controllers
        if let splitViewController = splitViewController {
            if splitViewController.isCollapsed {
                let detailViewController = storyboard?.instantiateViewController(identifier: "patientDetailsViewController") as! PatientDetailsViewController
                detailViewController.patient = selectedPatient
                splitViewController.showDetailViewController(detailViewController, sender: nil)
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsets.zero
    }
}


private extension PatientListViewController {
    
    private func getPatients() {
        let url = Bundle.main.url(forResource: "patientData", withExtension: "json")!
        
        do {
            let jsonData = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let service = try decoder.decode(PatientDataService.self, from: jsonData)
            patients = service.entry.map { Patient(from: $0)}
            
            self.tableView.reloadData()
            //delegate?.patientSelected(patients[0])
        }
        catch {
            //print("Error info: \(error)")
            ToastView.showInParent(self.view, "Data loading failed")
        }
    }
}
