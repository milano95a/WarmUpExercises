//
//  ProductListViewModel.swift
//  WarmUpExercises
//
//  Created by Workspace on 10/02/23.
//

import Foundation
import RealmSwift

class ProductListViewModel {
    static let shared = ProductListViewModel()
    private init() {}
    
    var realm = try! Realm()
    @ObservedResults(Product.self) var products
    
    func update(_ product: Product, _ name: String, _ cost: Int) {
        guard let thawedObj = product.thaw() else { return }
        assert(thawedObj.isFrozen == false)
        guard let thawedRealm = thawedObj.realm else { return }
        do {
            try thawedRealm.write {
                thawedObj.name = name
                thawedObj.cost = cost
            }
        } catch let error {
            print(error)
        }
    }
    
    func delete(_ product: Product) {
        guard let thawedObj = product.thaw() else { return }
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
    
    func create(_ name: String, _ cost: Int) {
        let product = Product()
        product.name = name
        product.cost = cost
        do {
            try realm.write {
                realm.add(product)
            }
        } catch let error {
            print(error)
        }
    }
}
