//
//  GoReactiveTestCase.swift
//  GoReactive_Tests
//
//  Created by Gal Orlanczyk on 27/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import GoReactive

open class GoReactiveTestCase: XCTestCase {
    
    public let cancelableGroup = CancelableGroup()
    
    #if TRACE_REFERENCE_COUNT
    private var startReferenceCount: Int = 0
    #endif
    
    override open func setUp() {
        super.setUp()
        #if TRACE_REFERENCE_COUNT
        self.startReferenceCount = ReferencesTracer.count
        #endif
    }
    
    override open func tearDown() {
        super.tearDown()
        #if TRACE_REFERENCE_COUNT
        print("reference count before canceling, start count: \(self.startReferenceCount), current count: \(ReferencesTracer.count)")
        #endif
        self.cancelableGroup.cancel()
        #if TRACE_REFERENCE_COUNT
        print("reference count after canceling, start count: \(self.startReferenceCount), current count: \(ReferencesTracer.count)")
        XCTAssertEqual(self.startReferenceCount, ReferencesTracer.count)
        #endif
    }
}
