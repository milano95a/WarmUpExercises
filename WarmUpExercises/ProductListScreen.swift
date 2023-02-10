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
    var viewModel = ProductListViewModel.shared
    
    var body: some View {
        NavigationStack {
            List(products, id: \.self) { product in
                HStack {
                    Text(product.name)
                        .font(.custom("SourceSansPro-Black", size: 20))
                    Spacer()
                    Text("\(product.cost)")
                        .foregroundColor(Color.gray)
                        .font(.custom("SourceSansPro-Black", size: 16))
                }
                .swipeActions(content: {
                    Button("Delete") {
                        viewModel.delete(product)
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
                        .font(.custom("SourceSansPro-Black", size: 20))
                })
            })
        }
    }    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {        
        ProductListScreen().onAppear {
            let product = Product()
            product.name = "Snickers"
            product.cost = 7000
            let realm = try! Realm()
            try! realm.write {
                realm.deleteAll()
                realm.add(product)
            }
        }
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
