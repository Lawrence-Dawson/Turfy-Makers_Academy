//
//  LoginViewControllerTests.swift
//  Turfy
//
//  Created by Tam Borine on 02/11/2016.
//  Copyright © 2016 Lawrence Dawson. All rights reserved.
//

import XCTest
@testable import Turfy


class UserTests: XCTestCase {
    
    let user = User(uid: "12345", name: "Tam", email: "asdf@asdf.com")
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testToAnyObjectConvertsSnapshotToDict() {
        XCTAssertTrue((user.toAnyObject() as Any) is NSDictionary)
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
