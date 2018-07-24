//
//  Item.swift
//  Todoey
//
//  Created by José María Aguíñiga Díaz on 19/07/18.
//  Copyright © 2018 José María Aguíñiga Díaz. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    
    
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
