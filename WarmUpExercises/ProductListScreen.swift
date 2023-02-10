//
//  ContentView.swift
//  WarmUpExercises
//
//  Created by Workspace on 10/02/23.
//

import SwiftUI
import RealmSwift

struct ProductListScreen: View {
    @ObservedResults(Product.self) var products
    
    var body: some View {
        NavigationStack {
            List(products, id: \.self) { product in
                HStack {
                    Text(product.name)
                    Spacer()
                    Text("\(product.cost)")
                }
                .swipeActions(content: {
                    Button("Delete") {
                        guard let thawedObj = product.thaw() else { return }
                        assert(thawedObj.isFrozen == false)
                        guard let thawedRealm = thawedObj.realm else { return }
                        try! thawedRealm.write {
                            thawedRealm.delete(thawedObj)
                        }
                    }.tint(Color.red)
                    NavigationLink(destination: ProductEditorScreen(product: product), label: {
                        Text("Update")
                    }).tint(Color.blue)
                })
            }
            .navigationTitle("Products")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                NavigationLink(destination: ProductEditorScreen(), label: {
                    Text("add")
                })
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListScreen()
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
