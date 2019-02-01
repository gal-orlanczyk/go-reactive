//
//  ReactiveComponentUIButtonTests.swift
//  GoReactive_Tests
//
//  Created by Gal Orlanczyk on 28/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import GoReactive

class ReactiveComponentUIButtonTests: GoReactiveTestCase {

    let button = UIButton(frame: .zero)

    func testTitle() {
        let stringProperty = Property<String?>("")
        stringProperty.bind(to: self.button.reactiveComponent.title()).add(to: self.cancelableGroup)
        stringProperty.value = "test"
        XCTAssertEqual(stringProperty.value, button.title(for: []))
    }
    
    func testAttributedTitle() {
        let attributedStringProperty = Property<NSAttributedString?>(NSAttributedString(string: ""))
        attributedStringProperty.bind(to: self.button.reactiveComponent.attributedTitle()).add(to: self.cancelableGroup)
        attributedStringProperty.value = NSAttributedString(string: "test")
        XCTAssertEqual(attributedStringProperty.value, button.attributedTitle(for: []))
    }
    
    func testTap() {
        let buttonExpectation = expectation(description: "wait for button to be pressed")
        self.button.reactiveComponent.touchUpInside.subscribe(onNext: {
            buttonExpectation.fulfill()
        }).add(to: self.cancelableGroup)
        self.button.sendActions(for: .touchUpInside)
        wait(for: [buttonExpectation], timeout: 1)
    }
    
}
