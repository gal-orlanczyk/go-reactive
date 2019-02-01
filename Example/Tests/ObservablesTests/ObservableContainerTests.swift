//
//  ObservableContainerTests.swift
//  GoReactive_Tests
//
//  Created by Gal Orlanczyk on 27/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import GoReactive

class ObservableContainerTests: GoReactiveTestCase {

    var observable: Observable<Int>?
    
    override func tearDown() {
        self.observable = nil
        super.tearDown()
    }
    
    // tests that an observable stream gets deallocated properly
    // and that .onCompleted event is clearing the subscription from continuing.
    func testObservableContainerCreationAndRelease() {
        weak var weakObserver: Observer<Int>?
        self.observable = Observable<Int>.create { (observer) -> Cancelable in
            weakObserver = observer
            observer.onNext(0)
            observer.onNext(1)
            observer.onCompleted()
            observer.onNext(2)
            return Cancelables.create()
        }
        
        let subscription = observable?.subscribe(onNext: { (element) in
            print(element)
            XCTAssertNotNil(weakObserver)
            XCTAssertTrue(element == 0 || element == 1)
        })
        
        XCTAssertNil(weakObserver)
        subscription?.cancel()
        
        #if TRACE_REFERENCE_COUNT
        XCTAssertEqual(ReferencesTracer.count, 1)
        #endif
    }
    
    // tests an async flow of a created observable and the release of it.
    func testObservableContainerCreationAndReleaseAsync() {
        let asyncExpectation = expectation(description: "wait for observer to release")
        weak var weakObserver: Observer<Int>?
        self.observable = Observable<Int>.create { (observer) -> Cancelable in
            weakObserver = observer
            observer.onNext(0)
            observer.onNext(1)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                observer.onNext(2)
            })
            return Cancelables.create()
        }
        
        let subscription = observable?.subscribe(onNext: { (element) in
            print(element)
            XCTAssertTrue(element == 0 || element == 1 || element == 2)
            if element == 2 {
                asyncExpectation.fulfill()
            }
        })
        
        XCTAssertNotNil(weakObserver)
        waitForExpectations(timeout: 2) { (error) in
            guard error == nil else { XCTFail(); return }
            subscription?.cancel()
        }
    }
    
}
