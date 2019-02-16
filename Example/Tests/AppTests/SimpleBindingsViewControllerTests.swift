//
//  SimpleBindingsViewControllerTests.swift
//  GoReactive_Tests
//
//  Created by Gal Orlanczyk on 19/01/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import GoReactive
import GoReactiveTests
@testable import GoReactive_Example

class SimpleBindingsViewControllerTests: GoReactiveTestCase {

    func testSimpleBindingsViewController() {
        let simpleBindingsVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SimpleBindingsViewController") as! SimpleBindingsViewController
        // make sure to load view so viewDidLoad will be called.
        let _ = simpleBindingsVC.view
        let testString = "test test test"
        // tests the inner behaviours
        simpleBindingsVC.viewModel.bindableLabelProperty.value = testString
        XCTAssertEqual(simpleBindingsVC.bindableLabel.text, testString)
        simpleBindingsVC.viewModel.bindableTextFieldProperty.value = testString
        XCTAssertEqual(simpleBindingsVC.bindableTextField.text, testString)
    }

}
