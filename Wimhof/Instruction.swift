//
//  Instruction.swift
//  Wimhof
//
//  Created by Tomas Sukys on 2020-08-10.
//  Copyright © 2020 Tomas Sukys.lt. All rights reserved.
//

import UIKit

class Instruction: NSObject {
    var name: String
    var image: String
    var content: String
    
    init(name: String, image: String, content: String ) {
        self.name = name
        self.image = image
        self.content = content
    }
}
