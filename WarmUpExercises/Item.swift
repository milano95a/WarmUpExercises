//
//  User.swift
//  WarmUpExercises
//
//  Created by Workspace on 11/02/23.
//

import Foundation
import RealmSwift

class Item: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var monthName = ""
    @Persisted var spendingRate = 0.0
    
    var savingRate: Double {
        100 - spendingRate
    }
    
    var dailySpendingRate: Double {        
        spendingRate / 30
    }
    
    var daysGained: Double {
        if savingRate > 0 {
            return savingRate / dailySpendingRate            
        } else if savingRate < 0 {
            return -(spendingRate - 100) / 100 * 30
        } else {
            return 0
        }
    }
}

