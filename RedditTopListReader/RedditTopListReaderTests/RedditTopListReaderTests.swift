//
//  RedditTopListReaderTests.swift
//  RedditTopListReaderTests
//
//  Created by Andrei Pitsko on 8/30/18.
//  Copyright © 2018 Andrei Pitsko. All rights reserved.
//

import XCTest
@testable import RedditTopListReader

class DateFormatterAgoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testOneHourAgo() {
        let oneHourAgoDate = Calendar.current.date(byAdding: .hour, value: -1, to: Date())!
        XCTAssertEqual(oneHourAgoDate.timeAgoFormat(), "1 hr ago")
    }

    func testTwoDaysAgo() {
        let date = Calendar.current.date(byAdding: .day, value: -2, to: Date())!
        XCTAssertEqual(date.timeAgoFormat(), "2 days ago")
    }

    func testTenSecondsAgo() {
        let date = Calendar.current.date(byAdding: .second, value: -10, to: Date())!
        XCTAssertEqual(date.timeAgoFormat(), "10 sec ago")
    }

    func testOneWeekAgo() {
        let date = Calendar.current.date(byAdding: .weekOfMonth, value: -1, to: Date())!
        XCTAssertEqual(date.timeAgoFormat(), "1 wk ago")
    }

    func testTenYearsAgo() {
        let date = Calendar.current.date(byAdding: .year, value: -10, to: Date())!
        XCTAssertEqual(date.timeAgoFormat(), "10 yrs ago")
    }

    func testFiveMinitesAgo() {
        let date = Calendar.current.date(byAdding: .minute, value: -5, to: Date())!
        XCTAssertEqual(date.timeAgoFormat(), "5 min ago")
    }

    func testSixMonthAgo() {
        let date = Calendar.current.date(byAdding: .month, value: -6, to: Date())!
        XCTAssertEqual(date.timeAgoFormat(), "6 mths ago")
    }

}
