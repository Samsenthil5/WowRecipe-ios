//
//  UtilsTests.swift
//  WowRecipeTests
//
//  Created by Senthilmurugan on 8/22/20.
//  Copyright © 2020 Senthilmurugan. All rights reserved.
//

import XCTest
@testable import Wow_Recipe

class UtilsTests: MyBaseUnitTests {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUtilsDebugLog() {
        dLog("debug Log Testing")
        dLog("debug Log Testing, Invalid Filename", filename: "")
    }
    func testUIAlert() {
        let vcontroller = SearchRecipeViewController()
        Utils.showAlertView(title: "TestTitle", message: "Test Message", viewController: vcontroller) {
            self.testUIAlertViewController(vcontroller: vcontroller)
        }
    }
    func testUIAlertViewController(vcontroller: SearchRecipeViewController) {
        XCTAssertTrue(vcontroller.presentedViewController is UIAlertController)
        XCTAssertEqual(vcontroller.presentedViewController?.title, "Test Title")
    }
    func testColor() {
        _ = UIColor.convertHexToColor(hex: CustomColor.navigationBarTintColor)

        let error = RecipeError.unauthorized
        XCTAssertEqual(error.localizedDescription, RecipeError.unauthorizedMessage)
    }
}
