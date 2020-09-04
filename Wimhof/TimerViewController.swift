//
//  ResultViewController.swift
//  Wimhof
//
//  Created by Tomas Sukys on 2020-08-10.
//  Copyright © 2020 Tomas Sukys.lt. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    var results = [SavedResults]()
    
    // MARK: - outlets
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var milisecondsLabel: UILabel!
    @IBOutlet weak var startButtonLabel: UIButton!
    @IBOutlet weak var resetButtonLabel: UIButton!
    @IBOutlet weak var saveButtonLabel: UIButton!
    @IBOutlet weak var roundLabel: UILabel!
    
    // MARK: - variables
    var tempResult = ""
    var result = ""
    var minutes = 0
    var seconds = 0
    var miliseconds = 0
    var roundNumber = 1
    var currentDate = ""
    
    var lappedTimes: [String] = []
    var stopButtonIsActive = false
    var countBegins = false
    
    // Timer
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self

        //hide elements
        resetButtonLabel.isHidden = true
        saveButtonLabel.isHidden = true
        table.isHidden = true
        roundLabel.isHidden = true
    }
    
    //"Start/Stop" button actions
    @IBAction func startButton(_ sender: Any) {
        startTimer()
        
        stopButtonIsActive.toggle()
        //change button title
        if stopButtonIsActive == true {
            startButtonLabel.setTitle("STOP", for: .normal)
        } else {
            startButtonLabel.setTitle("START", for: .normal)
            lap()
        }

        //hide buttons
        resetButtonLabel.isHidden = false
        saveButtonLabel.isHidden = false
    }
    
    func startTimer() {
        //set to default value
        timer.invalidate()
        //start timer
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(countTime), userInfo: nil, repeats: true)
    }
    
    @objc func countTime() {
        if stopButtonIsActive == false {
            //reset to default values
            miliseconds = 0
            seconds = 0
            minutes = 0
            milisecondsLabel.text = "0"
            secondsLabel.text = "00"
            minuteLabel.text = "0"
        } else {
            //count time
            roundLabel.isHidden = false
            roundNumber = lappedTimes.count + 1
            roundLabel.text = "ROUND \(roundNumber)"
            
            //count miliseconds
            miliseconds += 1
            if miliseconds > 9 {
                miliseconds = 0
                seconds += 1
                if seconds < 10 {
                    secondsLabel.text = "0\(seconds)"
                } else {
                    secondsLabel.text = String(seconds)
                }
            }
            milisecondsLabel.text = String(miliseconds)
            
            //count seconds
            if seconds > 59 {
                seconds = 0
                minutes += 1
                minuteLabel.text = String(minutes)
            }
            
            //count minutes
            if minutes > 9 {
                timer.invalidate()
            }
        }
    }
    
    //push result to the tableview
    func lap() {
        tempResult = "\(minutes):\(seconds)"
        lappedTimes.append(tempResult)
        
        let indexPath = IndexPath(row: lappedTimes.count - 1, section: 0)
        table.insertRows(at: [indexPath], with: .automatic)
        table.isHidden = false
        
        setResult()
    }
    
    func setResult() {
        var tempResultMinutes = ""
        var tempResultSeconds = ""
        
        if minutes == 1 {
            tempResultMinutes = "\(minutes) minute"
        } else {
            tempResultMinutes = "\(minutes) minutes"
        }
        
        if seconds == 1 {
            tempResultSeconds = "\(seconds) second"
        } else {
            tempResultSeconds = "\(seconds) seconds"
        }
        
        result = "\(tempResultMinutes) \(tempResultSeconds)"
    }
    
    //reset all variables
    func reset() {
        timer.invalidate()
        miliseconds = 0
        seconds = 0
        minutes = 0
        lappedTimes = []
        milisecondsLabel.text = "0"
        secondsLabel.text = "00"
        minuteLabel.text = "0"
        roundLabel.isHidden = true
        stopButtonIsActive = false
        resetButtonLabel.isHidden = true
        saveButtonLabel.isHidden = true
        startButtonLabel.setTitle("START", for: .normal)
        table.reloadData()
    }
    
    //actions on click reset button
    @IBAction func resetButton(_ sender: Any) {
        reset()
    }
    
    //save result to user defaults
    @IBAction func saveButton(_ sender: Any) {
        dateFormater()
        let newResult = SavedResults(exerciseName: "Breathing Basic", result: result, date: currentDate)
        results.append(newResult)
        save()
        reset()
                
    }
    
    //format current date to string
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
            print("Data is not saved in TimerViewController")
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
extension TimerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lappedTimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lapCell", for: indexPath)
        cell.textLabel?.text = "ROUND \(indexPath.row + 1)"
        cell.detailTextLabel?.text = lappedTimes[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            lappedTimes.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

}
