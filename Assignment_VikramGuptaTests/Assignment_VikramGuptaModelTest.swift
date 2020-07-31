//
//  Assignment_VikramGuptaModelTest.swift
//  Assignment_VikramGuptaUITests
//
//  Created by Vikram Gupta on 7/24/20.
//  Copyright © 2020 Vikram Gupta. All rights reserved.
//

import XCTest
@testable import Assignment_VikramGupta

class Assignment_VikramGuptaModelTest: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // Model Class Test Cases
    func testFactModel(){
        let objModel = Facts(title: "About Canada", rows: [Row(title: "Beavers", description: "Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony", imageHref: "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg")])
        XCTAssertNotNil(objModel)
    }
    
    func testSearchResponse() throws {
        guard
            let path = Bundle.main.path(forResource: "response", ofType: "json")
            else { fatalError("Can't find search.json file") }
        
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        let response = try JSONDecoder().decode(Facts.self, from: data)
        let obj = response
        let objFacts = response.rows![0]
        
        XCTAssertEqual(obj.title, "About Canada")
        XCTAssertEqual(objFacts.title, "Beavers")
        XCTAssertEqual(objFacts.description, "Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony")
        XCTAssertEqual(objFacts.imageHref, "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg")
    }
    
    func testNumberOfRows() throws {
        let expectation = XCTestExpectation.init(description: "Pass")
        guard
            let path = Bundle.main.path(forResource: "response", ofType: "json")
            else { fatalError("Can't find search.json file") }
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        let response = try JSONDecoder().decode(Facts.self, from: data)
        let numberOfRows = response.rows
        if(numberOfRows!.count > 0){
            expectation.fulfill()
        } else{
            XCTFail("Fail")
        }
    }
}
