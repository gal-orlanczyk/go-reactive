//
//  ReactiveComponentUILabelTests.swift
//  GoReactive_Tests
//
//  Created by Gal Orlanczyk on 28/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import GoReactive

class ReactiveComponentUILabelTests: GoReactiveTestCase {

    let label = UILabel(frame: .zero)
    
    func testProperties() {
        let stringProperty = Property<String?>("")
        stringProperty.bind(to: self.label.reactiveComponent.text).add(to: self.cancelableGroup)
        stringProperty.value = "test"
        XCTAssertEqual(stringProperty.value, label.text)
        
        let attributedStringProperty = Property<NSAttributedString?>(NSAttributedString(string: ""))
        attributedStringProperty.bind(to: self.label.reactiveComponent.attributedText).add(to: self.cancelableGroup)
        attributedStringProperty.value = NSAttributedString(string: "test")
        XCTAssertEqual(attributedStringProperty.value, label.attributedText)
    }

}
