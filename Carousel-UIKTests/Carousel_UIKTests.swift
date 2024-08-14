//
//  Carousel_UIKTests.swift
//  Carousel-UIKTests
//
//  Created by Herlandro Hermogenes on 14/08/2024.
//

import XCTest
@testable import Carousel_UIK

final class Carousel_UIKTests: XCTestCase {

    var appCurrntVersion = AppData.shared.currentVersion
    var appFirstTimeVersion = "1.0(1)"
    var sut: ViewController!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = ViewController()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func test_should_show_carousel_when_app_run_first_time() {
        
        // Arrange

        // Act

        //Assert

    }

}
