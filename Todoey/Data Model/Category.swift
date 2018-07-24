//
//  Category.swift
//  Todoey
//
//  Created by José María Aguíñiga Díaz on 19/07/18.
//  Copyright © 2018 José María Aguíñiga Díaz. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var Name : String = ""
    let items = List<Item>()
    
}
