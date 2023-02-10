//
//  ProductEditorScreen.swift
//  WarmUpExercises
//
//  Created by Workspace on 10/02/23.
//

import SwiftUI
import RealmSwift

struct ProductEditorScreen: View {
    @State var product: Product?
    @State var name = ""
    @State var cost = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("name", text: $name)
                    .padding()
                TextField("cost", text: $cost)
                    .padding()
                Button("Save") {
                    save()
                }
                .padding()
                Spacer()
            }
            .navigationTitle("Editor")
            .onAppear {
                if let product = product {
                    name = product.name
                    cost = "\(product.cost)"
                }
            }
        }
    }
    
    private func save() {
        if let product = product {
            guard let thawedObj = product.thaw() else { return }
            assert(thawedObj.isFrozen == false)
            guard let thawedRealm = thawedObj.realm else { return }
            try! thawedRealm.write {
                thawedObj.name = name
                thawedObj.cost = Int(cost) ?? 0
            }
        } else {
            let product = Product()
            product.name = name
            product.cost = Int(cost) ?? 0
            let realm = try! Realm()
            try! realm.write {
                realm.add(product)
            }
        }
    }
}

//struct Preview_ProductEditorScreen: pro

struct ProductEditorScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProductEditorScreen()
    }
}
