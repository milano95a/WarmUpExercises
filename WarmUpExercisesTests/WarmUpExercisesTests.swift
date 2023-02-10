//
//  WarmUpExercisesTests.swift
//  WarmUpExercisesTests
//
//  Created by Workspace on 10/02/23.
//

import XCTest
import RealmSwift
@testable import WarmUpExercises

final class WarmUpExercisesTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testSave() throws {
        let sut = ProductListViewModel.shared
        let count = sut.products.count
        sut.create("test", 0)        
        let newCount = sut.products.count
        XCTAssertEqual(count+1, newCount, "new item not added")
    }
    
    func testUpdate() throws {
        let sut = ProductListViewModel.shared
        let product = sut.products.first { $0.name == "test" }
        XCTAssertNotNil(product)
        sut.update(product!, "test updated", 200)        
        let updatedProduct = sut.products.first { $0.name == "test updated" && $0.cost == 200 }
        XCTAssertNotNil(updatedProduct)
    }
    
    func testDelete() throws {
        let sut = ProductListViewModel.shared
        let product = sut.products.first { $0.name == "test updated" && $0.cost == 200 }
        XCTAssertNotNil(product)
        sut.delete(product!)
        let deletedProduct = sut.products.first { $0.name == "test updated" && $0.cost == 200 }
        XCTAssertNil(deletedProduct)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
