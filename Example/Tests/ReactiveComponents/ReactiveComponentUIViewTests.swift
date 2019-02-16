//
//  ReactiveComponentUIViewTests.swift
//  GoReactive_Tests
//
//  Created by Gal Orlanczyk on 28/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import GoReactive
import GoReactiveTests

class ReactiveComponentUIViewTests: GoReactiveTestCase {

    let view = UIView(frame: .zero)
    
    func testIsHidden() {
        let boolProperty = Property<Bool>(false)
        boolProperty.bind(to: self.view.reactiveComponent.isHidden).add(to: self.cancelableGroup)
        boolProperty.value = true
        XCTAssertEqual(boolProperty.value, view.isHidden)
    }

    func testAlpha() {
        let property = Property<CGFloat>(1)
        property.bind(to: self.view.reactiveComponent.alpha).add(to: self.cancelableGroup)
        property.value = 0
        XCTAssertEqual(property.value, view.alpha)
    }

}
