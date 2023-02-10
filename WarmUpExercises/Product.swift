//
//  Product.swift
//  WarmUpExercises
//
//  Created by Workspace on 10/02/23.
//

import Foundation
import RealmSwift

class Product: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name = ""
    @Persisted var cost = 0
}
