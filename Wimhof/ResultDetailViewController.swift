//
//  ResultDetailViewController.swift
//  Wimhof
//
//  Created by Tomas Sukys on 2020-08-13.
//  Copyright © 2020 Tomas Sukys.lt. All rights reserved.
//

import UIKit

class ResultDetailViewController: UIViewController {
    var results = [SavedResults]()
    
    // MARK: - outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var exerciseTitle: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var exerciseResult: UILabel!

    // MARK: - variables
    var exercise = ""
    var date = ""
    var result = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Details"

        imageView.image = UIImage(named: exercise)
        exerciseTitle.text = exercise
        dateLabel.text = date
        exerciseResult.text = "Result: \(result)"
        
    }
    
    //Remove selected result
    @IBAction func deleteButtonTapped(_ sender: Any) {
        let ac = UIAlertController(title: "Confirm delete", message: "Are you sure?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Yeah", style: .default, handler: deleteResult))
        ac.addAction(UIAlertAction(title: "No", style: .cancel))
        present(ac, animated: true)
//        for _ in results {
//            results.removeAll(where: {$0.exerciseName == exercise && $0.date == date && $0.result == result})
//        }
//        save()
//        self.navigationController?.popViewController(animated: true)
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
    
    func deleteResult(action: UIAlertAction) {
        for _ in results {
            results.removeAll(where: {$0.exerciseName == exercise && $0.date == date && $0.result == result})
        }
        save()
        self.navigationController?.popViewController(animated: true)
    }
    
}
