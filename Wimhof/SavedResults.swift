//
//  SavedResults.swift
//  Wimhof
//
//  Created by Tomas Sukys on 2020-08-05.
//  Copyright © 2020 Tomas Sukys.lt. All rights reserved.
//

import UIKit

class SavedResults: NSObject, Codable {
    var exerciseName = ""
    var result = ""
    var date = ""
    
    init(exerciseName: String, result: String, date: String) {
        self.exerciseName = exerciseName
        self.result = result
        self.date = date
    }
}
