//
//  ObservableProtocol.swift
//  GoReactive
//
//  Created by Gal Orlanczyk on 25/12/2018.
//

import Foundation

/// Represents a subscription closure.
public typealias SubscriptionHandler<E> = (Observer<E>) -> Cancelable

/// Represents an observable sequence of events
public protocol ObservableProtocol: Bindable {
    /// The type of element in sequence.
    associatedtype Element
    /// Provides an observable sequence of a concrete object.
    var asObservable: Observable<Element> { get }
    
    /// Subscribes to an observable sequence events.
    ///
    /// - Parameter observer: An observer reacting to events of the sequence.
    /// - Returns: Subscription object that can be used to cancel the observing.
    func subscribe<O: ObserverProtocol>(_ observer: O) -> Cancelable where O.Element == Element
    
    
    /// Creates a concrete observable instance from the observable protocol.
    ///
    /// - Parameter subscriptionHandler: The subscription handler to be used on new subscriptions.
    /// - Returns: Returns a new concreate observable instance using the provided subscription handler.
    static func create(with subscriptionHandler: @escaping SubscriptionHandler<Element>) -> Observable<Element>
}

/// Defines comformance of `Observable` object to bindable by subscribe to the observer.
public extension ObservableProtocol {
    
    func bind<O: ObserverProtocol>(to observer: O) -> Cancelable where O.Element == Element {
        return self.subscribe(observer)
    }
}

public extension ObservableProtocol {
    
    static func create(with subscriptionHandler: @escaping SubscriptionHandler<Element>) -> Observable<Element> {
        return ObservableContainer<Element>(subscriptionHandler)
    }
    
    func subscribe(on eventHandler: @escaping EventHandler<Element>) -> Cancelable {
        let observer = Observer<Element>(eventHandler: eventHandler)
        //return self.asObservable.subscribe(observer) // TODO: remove if not needed
        return self.subscribe(observer)
    }
    
    /// Type erasure for any observable implementing the protocol to a general `Observable` (same concept as AnyObject)
    var asObservable: Observable<Element> {
        return Self.create { (observer) -> Cancelable in
            self.subscribe(observer)
        }
    }
    
    func subscribe(onNext: ((Element) -> Void)? = nil, onError: ((Swift.Error) -> Void)? = nil, onCompleted: (() -> Void)? = nil) -> Cancelable {
        return self.subscribe(on: { (event) in
            switch event {
            case .next(let value): onNext?(value)
            case .error(let error): onError?(error)
            case .completed: onCompleted?()
            }
        })
    }
}
