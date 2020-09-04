//
//  ViewController.swift
//  Wimhof
//
//  Created by Tomas Sukys on 2020-07-30.
//  Copyright © 2020 Tomas Sukys.lt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var exercises: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
    }
    
    //navigate to ExerciseViewController
    @IBAction func viewExercisesTappes(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(identifier: "Exercises") as? ExercisesViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

