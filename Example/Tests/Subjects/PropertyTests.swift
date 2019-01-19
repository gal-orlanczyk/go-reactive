//
//  PropertyTests.swift
//  GoReactive_Tests
//
//  Created by Gal Orlanczyk on 28/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import GoReactive

class PropertyTests: GoReactiveTestCase {

    var intProp: Property<Int>!
    var intProp2: Property<Int>!
    
    override func setUp() {
        super.setUp()
        self.intProp = Property<Int>(0)
        self.intProp2 = Property<Int>(0)
    }

    override func tearDown() {
        self.intProp = nil
        self.intProp2 = nil
        super.tearDown()
    }

    func testSubscribe() {
        var currentElement = 0
        self.intProp.subscribe(onNext: { (element) in
            XCTAssertEqual(element, currentElement)
        }).add(to: self.cancelableGroup)
        self.intProp.value = currentElement
        currentElement = 1
        self.intProp.value = currentElement
    }

    func testBind() {
        var value = 1
        self.intProp.bind(to: self.intProp2).add(to: self.cancelableGroup)
        self.intProp2.subscribe(onNext: { (element) in
            XCTAssertEqual(element, value)
        }).add(to: self.cancelableGroup)
        self.intProp.value = value
        XCTAssertEqual(self.intProp.value, self.intProp2.value)
        value = 2
        self.intProp.value = value
        value = 3
        self.intProp.value = value
        XCTAssertEqual(self.intProp.value, self.intProp2.value)
    }
    
    func testBidirectionalBind() {
        self.intProp.bidirectionalBind(to: self.intProp2).add(to: self.cancelableGroup)
        var subscription = self.intProp.subscribe(onNext: { (element) in
            XCTAssertEqual(element, 0)
        })
        var subscription2 = self.intProp2.subscribe(onNext: { (element) in
            XCTAssertEqual(element, 0)
        })
        self.intProp2.value = 0
        subscription.cancel()
        subscription2.cancel()
        subscription = self.intProp.subscribe(onNext: { (element) in
            XCTAssertEqual(element, 1)
        })
        subscription2 = self.intProp2.subscribe(onNext: { (element) in
            XCTAssertEqual(element, 1)
        })
        self.intProp.value = 1
        subscription.cancel()
        subscription2.cancel()
    }
}
