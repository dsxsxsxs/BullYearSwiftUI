//
//  BullYearSwiftUITests.swift
//  BullYearSwiftUITests
//
//  Created by Jiacheng Shih on 2021/02/16.
//

import XCTest
@testable import BullYearSwiftUI

class BullYearSwiftUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let expection = XCTestExpectation()
        let sub = API().connect(config: IssueListRequest(page: 1))
            .sink(receiveCompletion: { _ in }) {

                XCTAssertFalse($0.isEmpty)
                expection.fulfill()
            }
        wait(for: [expection], timeout: 5)
        sub.cancel()
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
