//
//  ObserverProtocol.swift
//  GoReactive
//
//  Created by Gal Orlanczyk on 25/12/2018.
//

import Foundation

/// Represents an observer over an observable sequence
public protocol ObserverProtocol {
    /// The element types of the observer events
    associatedtype Element
    
    /// Notifies an event has occurred.
    ///
    /// - Parameter event: The event that occurred
    func on(_ event: Event<Element>)
}

public extension ObserverProtocol {
    /// Type erasure for any observer implementing the protocol to a general `Observer` (same concept as AnyObject)
    var asObserver: Observer<Element> {
        return Observer(self)
    }
}

public extension ObserverProtocol {
    
    func onNext(_ element: Element) {
        on(.next(element))
    }
    
    func onCompleted() {
        on(.completed)
    }
    
    func onError(_ error: Swift.Error) {
        on(.error(error))
    }
}
