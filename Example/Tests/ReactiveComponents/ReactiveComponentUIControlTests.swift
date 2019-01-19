//
//  ReactiveComponentUIControlTests.swift
//  GoReactive_Tests
//
//  Created by Gal Orlanczyk on 28/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import GoReactive

class ReactiveComponentUIControlTests: GoReactiveTestCase {
    
    let button = UIButton(frame: .zero)
    
    func testProperties() {
        let boolProperty = Property<Bool>(true)
        boolProperty.bind(to: self.button.reactiveComponent.isEnabled).add(to: self.cancelableGroup)
        boolProperty.value = false
        XCTAssertEqual(boolProperty.value, button.isEnabled)
    }
    
}
