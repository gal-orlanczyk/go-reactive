//
//  Property.swift
//  GoReactive
//
//  Created by Gal Orlanczyk on 25/12/2018.
//

import Foundation

/// Represents a property like object. whenever the property value changes it notfies all of the subscribers.
/// A property can also be bound into reactive components.
public class Property<E>: Observable<E>, Subject {
    
    private var observers = Observers<EventHandler<E>>()
    
    public var value: E {
        didSet {
            observers.items.forEach {
                $0(.next(value))
            }
        }
    }
    
    public func on(_ event: Event<E>) {
        switch event {
        case .next(let value): self.value = value
        default: break
        }
    }
    
    public init(_ value: E) {
        self.value = value
    }
    
    public override func subscribe<O: ObserverProtocol>(_ observer: O) -> Cancelable where E == O.Element {
        let uid = self.observers.insert(observer.on)
        return KeyedSubscription.init(keyedUnsubscriber: self, key: uid)
    }
}

/* ***********************************************************/
// MARK: - KeyedUnsubscriber
/* ***********************************************************/

extension Property: KeyedUnsubscriber {
    
    typealias Key = UInt64
    
    func unsubscribe(key: Key) {
        _ = self.observers.remove(uid: key)
    }
}

/* ***********************************************************/
// MARK: - Cancelable
/* ***********************************************************/

extension Property: Cancelable {
    
    public func cancel() {
        self.observers.removeAll()
    }
}
