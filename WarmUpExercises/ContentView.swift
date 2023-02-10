//
//  ContentView.swift
//  WarmUpExercises
//
//  Created by Workspace on 10/02/23.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
//    var products = ["snickers", "orea", "kit-kat"]
    @ObservedResults(Product.self) var products
    
    var body: some View {
        VStack {
            List(products, id: \.self) { product in
                HStack {
                    Text(product.name)
                    Spacer()
                    Text("\(product.cost)")
                }.swipeActions(content: {
                    Button("Delete") {
                        guard let thawedObj = product.thaw() else { return }
                        assert(thawedObj.isFrozen == false)
                        guard let thawedRealm = thawedObj.realm else { return }
                        try! thawedRealm.write {
                            thawedRealm.delete(thawedObj)
                        }
                    }.tint(Color.red)
                    Button("Update") {
                        guard let thawedObj = product.thaw() else { return }
                        assert(thawedObj.isFrozen == false)
                        guard let thawedRealm = thawedObj.realm else { return }
                        try! thawedRealm.write {
                            thawedObj.name = "\(thawedObj.name) udpated"
                        }
                    }.tint(Color.blue)
                })
            }
            Button("Save") {
                let product = Product()
                product.name = "Kit Kat"
                product.cost = 7_000
                let realm = try! Realm()
                try! realm.write {
                    realm.add(product)
                }
            }.modifier(MyButtonStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MyButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(8)
    }
}
