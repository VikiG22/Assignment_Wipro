//
//  Assignment_VikramGuptaTests.swift
//  Assignment_VikramGuptaTests
//
//  Created by Vikram Gupta on 7/23/20.
//  Copyright © 2020 Vikram Gupta. All rights reserved.
//

import XCTest
@testable import Assignment_VikramGupta

class Assignment_VikramGuptaTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testAPIWorking() {
        let expectation = XCTestExpectation.init(description: "Pass")
        ApiManager.shared.apiRequest(apiName: ApiName.facts) { result in
            switch result {
            case .success(_):
                expectation.fulfill()
            case .failure(_):
                XCTFail("Fail")
            }
        }
    }
    
    func testSetCell() throws{
        let objCellData = try testGetData().rows![0]
        let cell = DashboardTableViewCell()
        cell.setCellData(result: objCellData)
    }
    
    func testGetData() throws -> Facts{
        guard
            let path = Bundle.main.path(forResource: "response", ofType: "json")
            else { fatalError("Can't find search.json file") }
        
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        let response = try JSONDecoder().decode(Facts.self, from: data)
        return response
    }
    
    func testLoadImage() throws{
        let objCellData = try testGetData().rows![0]
        let objImageView = UIImageView()
        objImageView.loadImageUsingCache(withUrl: objCellData.imageHref!)
        
    }
    
    func testShowAlertMethod(){
        let objVC = UIViewController()
        objVC.showAlert(message: "Test Demo Message")
    }
    
    func testStartActivityIndicator(){
        let objVC = UIViewController()
        objVC.activityStartAnimating(activityColor: .gray, backgroundColor: .lightGray)
    }
    
    func testStopActivityIndicator(){
        let objVC = UIViewController()
        objVC.activityStopAnimating()
    }
}
