//
//  elearningCollectionViewController.swift
//  Wimhof
//
//  Created by Tomas Sukys on 2020-08-10.
//  Copyright © 2020 Tomas Sukys.lt. All rights reserved.
//

import UIKit

//private let reuseIdentifier = "Cell"

class ElearningCollectionViewController: UICollectionViewController {
    
    // MARK: - variables
    var instruction = [Instruction]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let explanation = Instruction(name: "Explanation", image: "explanation", content: "Explanation")
        let miniclass = Instruction(name: "Mini Class", image: "miniclass", content: "An introduction to Wim Hof Method.")
        let fundamentals = Instruction(name: "Fundamentals", image: "fundamentals", content: "Learn the Wim Hof Method with fun.")
        let classic = Instruction(name: "Classic Video Course", image: "classic", content: "Take the old-school approach.")
        let power = Instruction(name: "Power of the Mind", image: "power", content: "Deepen your training..")
        let fundamentalsDE = Instruction(name: "Fundamentals[DE]", image: "fundamentals", content: "Lerne die WHM fur deinen Alltag.")

        instruction = [explanation, miniclass, fundamentals, classic, power, fundamentalsDE]
        
        
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return instruction.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Instruction", for: indexPath) as? InstructionCell else {
            fatalError("Unable to dequeue PersonCell.")
        }
        
        let person = instruction[indexPath.item]
        cell.name.text = person.name
        cell.content.text = person.content
        cell.imageView.image = UIImage(named: person.image)

        //style image
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3

        //style image & name label
        cell.layer.cornerRadius = 7

        return cell
    }
    


}
