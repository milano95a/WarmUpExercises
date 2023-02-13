//
//  ContentViewModel.swift
//  WarmUpExercises
//
//  Created by Workspace on 11/02/23.
//

import Foundation
import RealmSwift

class ContentViewModel {
    static let shared = ContentViewModel()
    
    @ObservedResults(Item.self) var items 
    
    func delete(_ item: Item) {
        guard let thawedObj = item.thaw() else { return }
        assert(thawedObj.isFrozen == false)
        guard let thawedRealm = thawedObj.realm else { return }
        do {
            try thawedRealm.write {
                thawedRealm.delete(thawedObj)
            }            
        } catch let error {
            print(error)
        }
    }
    
    private func create(_ month: String, _ savingRate: String) {
//        do {
//            if let item = item {
//                guard let thawedObj = item.thaw() else { return }
//                assert(thawedObj.isFrozen == false)
//                guard let thawedRealm = thawedObj.realm else { return }
//                try thawedRealm.write {
//                    thawedObj.monthName = month
//                    thawedObj.spendingRate = Double(spendingRate) ?? 0.0
//                }
//            } else {
//                let item = Item()
//                item.monthName = month
//                item.spendingRate = Double(spendingRate) ?? 0.0
//                let realm = try Realm()
//                try realm.write {
//                    realm.add(item)
//                }
//            }
//        } catch let error {
//            print(error)
//        }
    } 
    
    private init() { }
}
