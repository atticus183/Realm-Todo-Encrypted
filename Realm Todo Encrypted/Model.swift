//
//  Model.swift
//  Realm Todo Encrypted
//
//  Created by Josh R on 1/21/19.
//  Copyright © 2019 Josh R. All rights reserved.
//

import Foundation
import RealmSwift

class Todo: Object {
    @objc dynamic var name = ""
    @objc dynamic var isCompleted = false
}
