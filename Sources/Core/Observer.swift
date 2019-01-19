//
//  Observer.swift
//  GoReactive
//
//  Created by Gal Orlanczyk on 25/12/2018.
//

import Foundation

/// Represent a single event in a sequence.
/// Can be:
/// * next - represents an event with value inside (whenever new data is available for a sequence).
/// * error - represents an error has occurred for the stream,
/// should dispose all of the observable resources when this event occurres.
/// * completed - represents a sequence has completed,
/// should dispose all of the observable resources when this event occurres.
///
/// Completed could be used for short lived streams like creating an observable for network requests.
/// Some sequences are infinite like UI components (we do not know when they end).
public enum Event<Value> {
    case next(Value)
    case error(Swift.Error)
    case completed
}

public typealias EventHandler<E> = (Event<E>) -> Void

/// A type earsed observer object.
public class Observer<E>: ReferenceTracableObject, ObserverProtocol {
    
    public typealias Element = E
    
    private let observerEventHandler: EventHandler<E>
    
    public init(eventHandler: @escaping EventHandler<E>) {
        self.observerEventHandler = eventHandler
    }
    
    public init<O: ObserverProtocol>(_ observer: O) where O.Element == E {
        self.observerEventHandler = observer.on
    }
    
    public func on(_ event: Event<E>) {
        self.observerEventHandler(event)
    }
    
    public func asObserver() -> Observer<Element> {
        return self
    }
}
