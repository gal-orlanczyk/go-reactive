//
//  ReactiveComponentUITextFieldTests.swift
//  GoReactive_Tests
//
//  Created by Gal Orlanczyk on 28/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import GoReactive

class ReactiveComponentUITextFieldTests: GoReactiveTestCase {

    let textField = UITextField(frame: .zero)

    override func setUp() {
        super.setUp()
        self.textField.text = nil
        self.textField.attributedText = nil
    }

    func testTextBind() {
        let stringProperty = Property<String?>(nil)
        stringProperty.bind(to: self.textField.reactiveComponent.text).add(to: self.cancelableGroup)
        stringProperty.value = "test"
        XCTAssertEqual(stringProperty.value, self.textField.text)
    }

    func testAttributedTextBind() {
        let attributedStringProperty = Property<NSAttributedString?>(nil)
        attributedStringProperty.bidirectionalBind(to: self.textField.reactiveComponent.attributedText).add(to: self.cancelableGroup)
        attributedStringProperty.value = NSAttributedString(string: "test")
        // for some reason textfield add attributes and this make the test fail,
        // so to overcome this we first set will string value and than take again with the attributes.
        let propertyString = attributedStringProperty.value!.string
        let attributedStringPropertyValue = NSAttributedString(string: propertyString, attributes: self.textField.attributedText!.attributes(at: 0, effectiveRange: nil))
        XCTAssertEqual(attributedStringPropertyValue, self.textField.attributedText)
    }
    
    func testTextBidirectionalBind() {
        let stringProperty = Property<String?>(nil)
        stringProperty.bidirectionalBind(to: self.textField.reactiveComponent.text).add(to: self.cancelableGroup)
        stringProperty.value = "test"
        XCTAssertEqual(stringProperty.value, self.textField.text)
        
        let subscribeExpectation = expectation(description: "wait for subscribe to handle")
        var observedCount = 0
        self.textField.reactiveComponent.text.subscribe(onNext: { (element) in
            observedCount += 1
        }).add(to: self.cancelableGroup)
        self.textField.text = "test2"
        self.textField.sendActions(for: .allEditingEvents)
        XCTAssertEqual(stringProperty.value, self.textField.text)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            XCTAssertEqual(observedCount, 1)
            subscribeExpectation.fulfill()
        }
        wait(for: [subscribeExpectation], timeout: 2)
    }
    
    func testAttributedTextBidirectionalBind() {
        let attributedStringProperty = Property<NSAttributedString?>(nil)
        attributedStringProperty.bidirectionalBind(to: self.textField.reactiveComponent.attributedText).add(to: self.cancelableGroup)
        attributedStringProperty.value = NSAttributedString(string: "test")
        // for some reason textfield add attributes and this make the test fail,
        // so to overcome this we first set will string value and than take again with the attributes.
        let propertyString = attributedStringProperty.value!.string
        let attributedStringPropertyValue = NSAttributedString(string: propertyString, attributes: self.textField.attributedText!.attributes(at: 0, effectiveRange: nil))
        XCTAssertEqual(attributedStringPropertyValue, self.textField.attributedText)

        let subscribeExpectation = expectation(description: "wait for subscribe to handle")
        var observedCount = 0
        self.textField.reactiveComponent.attributedText.subscribe(onNext: { (element) in
            observedCount += 1
        }).add(to: self.cancelableGroup)
        self.textField.attributedText = NSAttributedString(string: "test2")
        self.textField.sendActions(for: .allEditingEvents)
        let attributes = self.textField.attributedText!.attributes(at: 0, effectiveRange: nil)
        XCTAssertEqual(NSAttributedString(string: attributedStringProperty.value!.string, attributes: attributes), self.textField.attributedText)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            XCTAssertEqual(observedCount, 1)
            subscribeExpectation.fulfill()
        }
        wait(for: [subscribeExpectation], timeout: 2)
    }

}
