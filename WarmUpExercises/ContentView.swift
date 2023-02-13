//
//  ContentView.swift
//  WarmUpExercises
//
//  Created by Workspace on 10/02/23.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    
    @ObservedResults(Item.self) var items
    let viewModel = ContentViewModel.shared
    
    static let seventyOneYearsInDays = 25_932
    var daysLeft: Int {
        var daysLeft = ContentView.seventyOneYearsInDays
        for item in items {
            daysLeft -= Int(item.daysGained)
        }
        return daysLeft
    }
    var retirementThresholdYear: Int {
        daysLeft / 365
    }
    var retirementThresholdDay: Int {
        daysLeft - retirementThresholdYear * 365
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("\(retirementThresholdYear) year \(retirementThresholdDay) days old")
                        .padding()
                        .foregroundColor(.gray)
                        .font(.custom("SourceSansPro-Black", size: 32))
                    Spacer()
                }
                List(items.reversed()) { item in
                    HStack() {
                        Text(item.monthName)
                            .foregroundColor(.gray)
                            .font(.custom("SourceSansPro-Black", size: 18))
                        Spacer()
                        Text("\(Int(item.daysGained)) days")
                            .foregroundColor(item.daysGained > 0 ? .green : .red)
                            .font(.custom("SourceSansPro-Black", size: 20))
                    }
                    .swipeActions(content: {
                        Button("delete") {
                            viewModel.delete(item)
                        }
                        .tint(Color.red)
                        NavigationLink(destination: ContentEditor(item: item), label: {
                            Text("update")
                        }).tint(.blue)
                    })
                    .listRowBackground(Color.white)
                }
                .background(Color(red: 240/255, green: 240/255, blue: 240/255))
                .scrollContentBackground(.hidden)
                NavigationLink(destination: ContentEditor(), label: {
                    HStack {
                        Spacer()
                        Text("add")
                        Spacer()                        
                    }.modifier(MyButtonStyle())
                }).padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            }
            .statusBarHidden()
            .background(Color.white)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().onAppear {
            let realm = try! Realm()
            try! realm.write {
                realm.deleteAll()
            }
            let item = Item()
            item.monthName = "Jan 2023"
            item.spendingRate = 36
            try! realm.write {
                realm.add(item)
            }
        }
    }
}

struct MyButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.green)
            .cornerRadius(10)
            .foregroundColor(.white)
            .font(.custom("SourceSansPro-Black", size: 20))
    }
}
