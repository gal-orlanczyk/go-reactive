//
//  ReactiveComponentUISwitchTests.swift
//  GoReactive_Tests
//
//  Created by Gal Orlanczyk on 28/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import GoReactive
import GoReactiveTests

class ReactiveComponentUISwitchTests: GoReactiveTestCase {

    let uiswitch = UISwitch(frame: .zero)
    
    func testIsOnBind() {
        self.uiswitch.isOn = false
        let boolProperty = Property<Bool>(false)
        boolProperty.bind(to: self.uiswitch.reactiveComponent.isOn).add(to: self.cancelableGroup)
        boolProperty.value = true
        XCTAssertEqual(boolProperty.value, uiswitch.isOn)
    }
    
    func testIsOnBidirectionalBind() {
        self.uiswitch.isOn = false
        let boolProperty = Property<Bool>(false)
        boolProperty.bidirectionalBind(to: self.uiswitch.reactiveComponent.isOn).add(to: self.cancelableGroup)
        let switchExpectation = expectation(description: "wait for switch and observable")
        // tests subscribing work
        self.uiswitch.reactiveComponent.isOn.subscribe(onNext: { (element) in
            switchExpectation.fulfill()
        }).add(to: self.cancelableGroup)
        // change switch value programtically
        self.uiswitch.isOn = true
        self.uiswitch.sendActions(for: .valueChanged)
        // make sure when changing switch value the bound property is also set
        XCTAssertEqual(boolProperty.value, self.uiswitch.isOn)
        boolProperty.value = false
        // make sure the switch value is updated when bound to specific subject.
        XCTAssertEqual(boolProperty.value, self.uiswitch.isOn)
        wait(for: [switchExpectation], timeout: 1)
    }

}
