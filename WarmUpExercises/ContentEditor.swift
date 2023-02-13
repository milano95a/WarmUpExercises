//
//  ContentEditor.swift
//  WarmUpExercises
//
//  Created by Workspace on 11/02/23.
//

import SwiftUI 
import RealmSwift

struct ContentEditor: View {
    @State var month = ""
    @State var spendingRate = ""
    @State var item: Item?
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("month", text: $month)
                    .font(.custom("SourceSansPro-Black", size: 16))
                    .padding()
                TextField("spending rate", text: $spendingRate)
                    .font(.custom("SourceSansPro-Black", size: 16))
                    .padding()
                Button("Save") {
                    save()
                    dismiss()
                }.modifier(MyButtonStyle())
                Spacer()
            }.background(Color.white)
        }.onAppear {
            if let item = item {
                month = item.monthName
                spendingRate = "\(item.spendingRate)"
            }
        }
    }
    
    private func save() {
        do {
            if let item = item {
                guard let thawedObj = item.thaw() else { return }
                assert(thawedObj.isFrozen == false)
                guard let thawedRealm = thawedObj.realm else { return }
                try thawedRealm.write {
                    thawedObj.monthName = month
                    thawedObj.spendingRate = Double(spendingRate) ?? 0.0
                }
            } else {
                let item = Item()
                item.monthName = month
                item.spendingRate = Double(spendingRate) ?? 0.0
                let realm = try Realm()
                try realm.write {
                    realm.add(item)
                }
            }
        } catch let error {
            print(error)
        }
    } 
}

struct ContentEditor_Previews: PreviewProvider {
    static var previews: some View {
        ContentEditor()
    }
}
