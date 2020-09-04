//
//  ExercisesViewController.swift
//  Wimhof
//
//  Created by Tomas Sukys on 2020-07-31.
//  Copyright © 2020 Tomas Sukys.lt. All rights reserved.
//

import UIKit

class ExercisesViewController: UITableViewController {

    // MARK: - outlets
    @IBOutlet var breathingIcon: UIImageView!
    @IBOutlet var commitmentIcon: UIImageView!
    @IBOutlet var colTherapyIcon: UIImageView!
    
    // MARK: - variables
    var breathingIconTapped = UITapGestureRecognizer()
    var commitmentIconTapped = UITapGestureRecognizer()
    var coldTherapyIconTapped = UITapGestureRecognizer()
    var techniqueTitle = "breathing"
    var countRows = 0
    var titleForExercise = [String]()
    var contentForExercise = [String]()
    var iconForExercise = [String]()
    
    var breathExercises = [
        "breathing": [
            [
                "icon": "Breathing Basic",
                "title": "Breathing Basic",
                "content": "Every training begins with proper breathing. Sit or lie comfortably in a relaxing environment, and calm your mind."
            ],
            [
                "icon": "Push-ups",
                "title": "Push-ups",
                "content": "Charge up for the push-ups exercise. set a goal, relax and start with the breathing technique."
            ],
            [
                "icon": "4 Minute Meditation",
                "title": "4 Minute Meditation",
                "content": "Inhale deeply, then let the air go. Repeat this 30 times. After the final exhalation, stop drawing breath"
            ]
        ],
        "commitment": [
            [
                "icon": "Forward Bending",
                "title": "Forward Bending",
                "content": "Sit down with your legs stretched out in front of you. Exhale, and bend over towards your knees as far as you can go."
            ],
            [
                "icon": "Reverse Balance",
                "title": "Reverse Balance",
                "content": "Let on your back, bring your legs up, and point your toes to the sky."
            ],
            [
                "icon": "Headstand",
                "title": "Headstand",
                "content": "With this exercise you stimulate blood flow through a battle with gravity, while also working your shoulder & neck muscles."
            ],
            [
                "icon": "The shelf",
                "title": "The shelf",
                "content": "There are a few different ways to perform this exercise: you can rest your fists or your outstreched palms, and twist your wrists."
            ]
        ],
        "cold therapy": [
            [
                "icon": "Cold Shower",
                "title": "Cold Shower",
                "content": "The cold is not a hostile force, but rather an ally that helps revitalize key physiological processes."
            ],
            [
                "icon": "Ice Bath",
                "title": "Ice Bath",
                "content": "Star by taking long, deep breaths. Slowly enter the water. The enveloping cold may be overhelming at first, and induce a gasp reflex."
            ]
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "EXERCISES"
        
        tableView.rowHeight = 200
        
        //show table with assigned data
        breathingIconTapped = UITapGestureRecognizer(target: self, action: #selector(tapOnBreathingIcon))
        breathingIcon.addGestureRecognizer(breathingIconTapped)
        breathingIcon.isUserInteractionEnabled = true
        
        commitmentIconTapped = UITapGestureRecognizer(target: self, action: #selector(tapOnCommitmentIcon))
        commitmentIcon.addGestureRecognizer(commitmentIconTapped)
        commitmentIcon.isUserInteractionEnabled = true
        
        coldTherapyIconTapped = UITapGestureRecognizer(target: self, action: #selector(tapOnColdTherapyIcon))
        colTherapyIcon.addGestureRecognizer(coldTherapyIconTapped)
        colTherapyIcon.isUserInteractionEnabled = true
        
        
        
        tapOnBreathingIcon()
    }
    
    //assign values when tap on Icon
    @objc func tapOnBreathingIcon() {
        titleForExercise.removeAll()
        contentForExercise.removeAll()
        iconForExercise.removeAll()
        techniqueTitle = "breathing"
        countRows = breathExercises["breathing"]!.count
        for item in breathExercises["breathing"]! {
            titleForExercise.append(item.first(where: {$0.key == "title"})!.value)
            contentForExercise.append(item.first(where: {$0.key == "content"})!.value)
            iconForExercise.append(item.first(where: {$0.key == "icon"})!.value)
        }
        tableView.reloadData()
        
    }
    
    //assign values when tap on Icon
    @objc func tapOnCommitmentIcon() {
        titleForExercise.removeAll()
        contentForExercise.removeAll()
        iconForExercise.removeAll()
        techniqueTitle = "commitment"
        countRows = breathExercises["commitment"]!.count
        for item in breathExercises["commitment"]! {
            titleForExercise.append(item.first(where: {$0.key == "title"})!.value)
            contentForExercise.append(item.first(where: {$0.key == "content"})!.value)
            iconForExercise.append(item.first(where: {$0.key == "icon"})!.value)
        }
        tableView.reloadData()
        
    }
    
    //assign values when tap on Icon
    @objc func tapOnColdTherapyIcon() {
        titleForExercise.removeAll()
        contentForExercise.removeAll()
        iconForExercise.removeAll()
        techniqueTitle = "cold therapy"
        countRows = breathExercises["cold therapy"]!.count
        for item in breathExercises["cold therapy"]! {
            titleForExercise.append(item.first(where: {$0.key == "title"})!.value)
            contentForExercise.append(item.first(where: {$0.key == "content"})!.value)
            iconForExercise.append(item.first(where: {$0.key == "icon"})!.value)
        }
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countRows
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = titleForExercise[indexPath.row]
        cell.detailTextLabel?.text = contentForExercise[indexPath.row]
        cell.imageView?.image = UIImage(named: iconForExercise[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Instruction") as? InstructionTableViewController {
            vc.exerciseTitle = titleForExercise[indexPath.row]
            vc.contentText = contentForExercise[indexPath.row]
            navigationController?.pushViewController(vc, animated:  true)
        }
    }
    
    
}
