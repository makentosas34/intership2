//
//  ResultsViewController.swift
//  Wimhof
//
//  Created by Tomas Sukys on 2020-08-12.
//  Copyright © 2020 Tomas Sukys.lt. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    // MARK: - outlets
    @IBOutlet weak var picker: UIDatePicker!
    @IBOutlet weak var table: UITableView!
    
    // MARK: - variables
    var results = [SavedResults]()
    var sortedResults = [SavedResults]()
    var dateString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        
        table.isHidden = true
        
        picker.datePickerMode = .date
        
        loadUserDefaults()
        dateFormatter()
        showDataBySelectedDate()
    }
    
    //update data on view
    override func viewWillAppear(_ animated: Bool) {
        loadUserDefaults()
        showDataBySelectedDate()
        table.reloadData()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
    
    //update table view when picker component changes
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateString = dateFormatter.string(from: sender.date)
        showDataBySelectedDate()
        table.reloadData()
    }
    
    //set current date to string
    func dateFormatter() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateString = dateFormatter.string(from: Date())
    }
    
    //filter results to much selected date
    func showDataBySelectedDate() {
        sortedResults = results.filter { $0.date == dateString}
        if sortedResults.count != 0 {
            table.isHidden = false
        } else {
            table.isHidden = true
        }
    }
    
    //load data to user Defaults
    func save() {
        let jsonEncoder = JSONEncoder()
        
        if let savedData = try? jsonEncoder.encode(results) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "savedData")
        } else {
            print("Data is not saved")
        }
    }

    //load results from user defaults
    func loadUserDefaults() {
        let defaults = UserDefaults.standard
        
        if let savedResults = defaults.object(forKey: "savedData") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                results = try jsonDecoder.decode([SavedResults].self, from: savedResults)
            } catch {
                print("No data found")
            }
        }
    }
    

}

//set up table view
extension ResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = sortedResults[indexPath.row].exerciseName
        cell.detailTextLabel?.text = sortedResults[indexPath.row].result
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? ResultDetailViewController {
            vc.exercise = sortedResults[indexPath.row].exerciseName
            vc.result = sortedResults[indexPath.row].result
            vc.date = sortedResults[indexPath.row].date
            vc.results = results
            navigationController?.pushViewController(vc, animated: true)
        } else {
            print("not found")
        }
    }
    

}
