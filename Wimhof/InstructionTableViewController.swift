//
//  InstructionTableViewController.swift
//  Wimhof
//
//  Created by Tomas Sukys on 2020-08-05.
//  Copyright © 2020 Tomas Sukys.lt. All rights reserved.
//

import UIKit

class InstructionTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate  {
    
    // MARK: - outlets
    @IBOutlet var instruction: UILabel!
    @IBOutlet var content: UILabel!
    @IBOutlet var expandButton: UIButton!
    @IBOutlet var picker: UIPickerView!
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - variables
    var results = [SavedResults]()
    var exerciseTitle = ""
    var result = ""
    var tempresult = ["0 Minutes", "0 Seconds"]
    var timeResult = [String]()
    var contentText = ""
    var currentDate = ""
    
    var pickerValues = ["Moderate", "Good", "Fantastic"]
    var pickerValuesMinutesSeconds: [[String]] = [[String]]()
    var pickerValuesForPushUps = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        picker.dataSource = self
        
        valuesForPicker()
        
        saveButton.isEnabled = false
        instruction.text = "Instruction"
        content.text = contentText
        
        loadUserDefaults()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if exerciseTitle == "Push-ups" {
            return 1
        }
        
        if exerciseTitle == "Breathing Basic" {
            return 2
        }

        if exerciseTitle == "Cold Shower" {
            return 2
        }
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if exerciseTitle == "Push-ups" {
            return pickerValuesForPushUps.count
        }
        
        if exerciseTitle == "Breathing Basic" || exerciseTitle == "Cold Shower"{
            return pickerValuesMinutesSeconds[component].count
        }

        return pickerValues.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if exerciseTitle == "Push-ups" {
            return pickerValuesForPushUps[row]

        }
        
        if exerciseTitle == "Breathing Basic" || exerciseTitle == "Cold Shower"  {
            return pickerValuesMinutesSeconds[component][row]
        }

        return pickerValues[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if exerciseTitle == "Breathing Basic" || exerciseTitle == "Cold Shower" {
            //insert picker minutes value to temporary result
            if pickerValuesMinutesSeconds[component][row].hasSuffix("minutes") || pickerValuesMinutesSeconds[component][row].hasSuffix("minute") {
                tempresult.remove(at: 0)
                tempresult.insert(pickerValuesMinutesSeconds[component][row], at: 0)
            //insert picker seconds value to temporary result
            } else if pickerValuesMinutesSeconds[component][row].hasSuffix("seconds") || pickerValuesMinutesSeconds[component][row].hasSuffix("second") {
                tempresult.remove(at: 1)
                tempresult.insert(pickerValuesMinutesSeconds[component][row], at: 1)
            }
            //add picker values to the variable result
            result = "\(tempresult[0]) \(tempresult[1])"
            
        } else if exerciseTitle == "Push-ups" {
            result = pickerValuesForPushUps[row]
        } else {
            result = pickerValues[row]
        }
        
        dateFormater()
        
        if result != "" {
            saveButton.isEnabled = true
        }
    }
    
    //save result to user defaults
    @IBAction func saveButtonTapped(_ sender: Any) {
        let newResult = SavedResults(exerciseName: exerciseTitle, result: result, date: currentDate)
        results.append(newResult)
        save()
    
        self.navigationController?.popViewController(animated: true)
    }
    
    //format date to string
    func dateFormater() {
        let formatter = DateFormatter()
        formatter.dateStyle = .short

        currentDate = formatter.string(from: Date())
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
    
    //creates values for pickers
    func valuesForPicker() {
        //value for exercise with title "Push-ups"
        if exerciseTitle == "Push-ups" {
            for number in 0...100 {
                pickerValuesForPushUps.append(String(number))
            }
        } else if exerciseTitle == "Breathing Basic" || exerciseTitle == "Cold Shower" {
            //value for exercise with title "Breathing Basic" & "Cold Shower"
            pickerValuesMinutesSeconds.removeAll()
            let minutes = ["0 minutes", "1 minute", "2 minutes", "3 minutes", "4 minutes", "5 minutes", "6 minutes", "7 minutes", "8 minutes", "9 minutes", "10 minutes", "11 minutes", "12 minutes", "13 minutes", "14 minutes", "15 minutes", "16 minutes", "17 minutes", "18 minutes", "19 minutes", "20 minutes", "21 minutes", "22 minutes", "23 minutes", "24 minutes", "25 minutes", "26 minutes", "27 minutes", "28 minutes", "29 minutes", "30 minutes", "31 minutes", "32 minutes", "33 minutes", "34 minutes", "35 minutes", "36 minutes", "37 minutes", "38 minutes", "39 minutes", "40 minutes", "41 minutes", "42 minutes", "43 minutes", "44 minutes", "45 minutes", "46 minutes", "47 minutes", "48 minutes", "49 minutes", "50 minutes", "51 minutes", "52 minutes", "53 minutes", "54 minutes", "55 minutes", "56 minutes", "57 minutes", "58 minutes", "59 minutes"]

            let seconds = ["0 seconds", "1 second", "2 seconds", "3 seconds", "4 seconds", "5 seconds", "6 seconds", "7 seconds", "8 seconds", "9 seconds", "10 seconds", "11 seconds", "12 seconds", "13 seconds", "14 seconds", "15 seconds", "16 seconds", "17 seconds", "18 seconds", "19 seconds", "20 seconds", "21 seconds", "22 seconds", "23 seconds", "24 seconds", "25 seconds", "26 seconds", "27 seconds", "28 seconds", "29 seconds", "30 seconds", "31 seconds", "32 seconds", "33 seconds", "34 seconds", "35 seconds", "36 seconds", "37 seconds", "38 seconds", "39 seconds", "40 seconds", "41 seconds", "42 seconds", "43 seconds", "44 seconds", "45 seconds", "46 seconds", "47 seconds", "48 seconds", "49 seconds", "50 seconds", "51 seconds", "52 seconds", "53 seconds", "54 seconds", "55 seconds", "56 seconds", "57 seconds", "58 seconds", "59 seconds"]
            
            pickerValuesMinutesSeconds.append(minutes)
            pickerValuesMinutesSeconds.append(seconds)
        }
    }
    
}
