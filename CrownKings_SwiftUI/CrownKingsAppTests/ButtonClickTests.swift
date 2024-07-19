////
////  ButtonClickTests.swift
////  crownkingsbarbershop
////
////  Created by Joel Carter on 7/3/24.
////
//
//import Foundation
//
//import XCTest
//@testable import CrownKings_SwiftUI // Replace with your app's name
//
//class ButtonClickTests: XCTestCase {
//    @AppStorage("buttonLastClicked") private var buttonLastClicked: StorableDate?
//
//    override func setUp() {
//        super.setUp()
//        buttonLastClicked = nil // Reset for each test
//    }
//
//    func testCanClickInitially() {
//        XCTAssertTrue(canClickButton(), "Button should be clickable initially")
//    }
//
//    func testClickAndDisable() {
//        // Simulate a click
//        buttonLastClicked = StorableDate(date: Date())
//        XCTAssertFalse(canClickButton(), "Button should be disabled after click")
//    }
//
//    func testEnableAfterOneMonth() {
//        let calendar = Calendar.current
//        let oneMonthAgo = calendar.date(byAdding: .month, value: -1, to: Date())!
//        buttonLastClicked = StorableDate(date: oneMonthAgo)
//
//        XCTAssertTrue(canClickButton(), "Button should be enabled after one month")
//    }
//
//    func testEnableAfterSlightlyMoreThanOneMonth() {
//        let calendar = Calendar.current
//        let oneMonthAndOneDayAgo = calendar.date(byAdding: .day, value: -1, to: calendar.date(byAdding: .month, value: -1, to: Date())!)!
//        buttonLastClicked = StorableDate(date: oneMonthAndOneDayAgo)
//
//        XCTAssertTrue(canClickButton(), "Button should be enabled after slightly more than one month")
//    }
//
//    // ... add more test cases for different scenarios ...
//}
