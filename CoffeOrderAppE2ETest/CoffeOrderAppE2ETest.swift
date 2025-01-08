//
//  CoffeOrderAppE2ETest.swift
//  CoffeOrderAppE2ETest
//
//  Created by Rezaul Karim on 7/1/25.
//

import XCTest

final class when_app_is_launched_with_no_orders : XCTestCase {
    
    func test_should_make_sure_no_orders_messae_show() throws {
        let app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV" : "TEST"]
        app.launch()
        
        XCTAssertEqual("No Orders available!", app.staticTexts["noOrdersText"].label)
        
    }

}
