//
//  CanadaFactsTests.swift
//  CanadaFactsTests
//
//  Created by Vikram Gupta on 7/31/20.
//  Copyright © 2020 Vikram Gupta. All rights reserved.
//

import XCTest

@testable import CanadaFacts

class CanadaFactsTests: XCTestCase {
    var dashboardViewController : DashboardViewController!
    var window : UIWindow!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    override func setUp() {
        dashboardViewController = DashboardViewController(nibName: nil, bundle: nil)
        let navigationController = UINavigationController(rootViewController: dashboardViewController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        dashboardViewController.loadView()
        dashboardViewController.viewDidLoad()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // Test Navigation Item title nil
    func testNavigationItemTitleEmpty(){
        XCTAssertFalse(dashboardViewController.navigationItem.title == "")
    }
    
    // Test Navigation Item Title
    func testNavigationItemTitle(){
        let factsViewModel = FactsViewModel()
        factsViewModel.requestData(apiName: ApiName.facts) { (success, error) in
            if success {
                XCTAssertEqual(factsViewModel.getTitle(), "About Canada")
            }
            else {
                XCTFail("Fail")
            }
        }
    }
    
    // TableView Test Cases
    func testHasATableView() {
        XCTAssertNotNil(dashboardViewController.tableView)
    }
    
    // TableView DataSource Test Cases
    func testTableViewHasDataSource() {
        XCTAssertNotNil(dashboardViewController.tableView.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(dashboardViewController.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(dashboardViewController.responds(to: #selector(dashboardViewController.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(dashboardViewController.responds(to: #selector(dashboardViewController.tableView(_:cellForRowAt:))))
    }
    
    // Test reuse identifier equal
    func testTableViewCellHasReuseIdentifier() {
        let cell = dashboardViewController.tableView(dashboardViewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? DashboardTableViewCell
        let actualReuseIdentifer = cell?.reuseIdentifier
        let expectedReuseIdentifier = DashboardViewController.cellIdentifier
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }
    
    // Test reuse identifier not equal
    func testTableViewCellHasReuseIdentifierNotEqual() {
        let cell = dashboardViewController.tableView(dashboardViewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? DashboardTableViewCell
        let actualReuseIdentifer = cell?.reuseIdentifier
        let invalidIdentifier = "invalid_identifier"
        XCTAssertNotEqual(actualReuseIdentifer, invalidIdentifier)
    }
    
    // API Calling Test Cases
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
    
    // Read response.json file data
    func testGetData() throws -> Facts{
        guard
            let path = Bundle.main.path(forResource: "response", ofType: "json")
            else { fatalError("Can't find search.json file") }
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        let response = try JSONDecoder().decode(Facts.self, from: data)
        XCTAssertNotNil(response, "Fail to get response from json file")
        return response
    }
    
    // TableViewCell load image Test Cases
    func testLoadImage() throws{
        let objCellData = try testGetData().rows![0]
        let objImageView = UIImageView()
        objImageView.loadImageUsingCache(withUrl: objCellData.imageHref!)
        XCTAssertNotNil(objImageView, "Fail to load image using url")
    }
    
    func testNilDescription() throws{
        let objCellData = try testGetData().rows![1]
        XCTAssertNil(objCellData.description, "Nil description")
    }
    
    // Test check cell not nil
    func testSetCell() throws{
        let objCellData = try testGetData().rows![0]
        let cell = DashboardTableViewCell()
        cell.setCellData(result: objCellData)
        XCTAssertNotNil(cell, "Fail to get cells")
    }
        
    // Controller Test Cases
    func testShowAlertMethod(){
        XCTAssertNotNil(dashboardViewController.showAlert(message: "Test Demo Message"), "Fail to show alert")
    }
    
    func testStartActivityIndicator(){
        XCTAssertNotNil(dashboardViewController.activityStartAnimating(activityColor: .gray, backgroundColor: .lightGray), "Fail to start activity indicator")
    }
    
    func testStopActivityIndicator(){
        XCTAssertNotNil(dashboardViewController.activityStopAnimating(), "Fail to hide activity indicator")
    }
}
