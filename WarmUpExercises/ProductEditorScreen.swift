//
//  ProductEditorScreen.swift
//  WarmUpExercises
//
//  Created by Workspace on 10/02/23.
//

import SwiftUI
import RealmSwift

struct ProductEditorScreen: View {
    @Environment(\.dismiss) var dismiss
    @State var product: Product?
    @State var name = ""
    @State var cost = ""
    var viewModel = ProductListViewModel.shared
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("name", text: $name)
                    .padding()
                TextField("cost", text: $cost)
                    .padding()
                Button("Save") {
                    if let product = product {
                        viewModel.update(product, name, Int(cost) ?? 0)
                    } else {
                        viewModel.create(name, Int(cost) ?? 0)
                    }
                    dismiss()
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
}

//struct Preview_ProductEditorScreen: pro

struct ProductEditorScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProductEditorScreen()
    }
}
